import 'dart:async';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

showLocationBottomSheetOnBoarding(
    BuildContext c, PageController pageController) {
  showModalBottomSheet(
    isDismissible: true,
    context: c,
    isScrollControlled: true,
    builder: (c) => LocationBottomSheet1(pageController: pageController),
  );
}

class LocationBottomSheet1 extends StatefulWidget {
  final PageController pageController;
  const LocationBottomSheet1({Key? key, required this.pageController})
      : super(key: key);

  @override
  State<LocationBottomSheet1> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet1> {
  late TextEditingController _controller;

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeolocationCubit, GeolocationState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              color: context.isDark
                  ? bottomSheetBackgroundBlackColor
                  : bottomSheetBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 25.h),
                decoration: BoxDecoration(
                  color: context.isDark
                      ? bottomSheetBackgroundBlackColor
                      : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                ),
                child: MediumText(text: 'manzilni_qidirish'.tr()),
              ),
              const SpaceHeight(),
              Container(
                height: context.height * .7,
                color: context.isDark
                    ? bottomSheetBackgroundBlackColor
                    : bottomSheetBackgroundColor,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _controller,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        onChanged: (v) {
                          if (v.isEmpty) {
                            state.positionList.clear();
                            setState(() {});
                          }
                          return searchRegion(v);
                        },
                        // decoration: InputDecoration(
                        //     fillColor: Colors.white,
                        //     filled: true,

                        //     hintText: 'manzil'.tr(),
                        //     border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(15.r),
                        //         borderSide: const BorderSide(
                        //             color: Colors.grey, width: 0.5)),
                        //     enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(15.r),
                        //         borderSide: const BorderSide(
                        //             color: Colors.grey, width: 0.5))),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'manzil'.tr(),
                          prefixIcon: Icon(
                            Icons.search,
                            color: context.isDark
                                ? const Color(0xffB5B9BC)
                                : const Color(0xff6D7379),
                          ),
                          hintStyle: TextStyle(
                            fontSize: AppSizes.size_16,
                            fontWeight: AppFontWeight.w_400,
                            color: textFormFieldHintColor,
                          ),
                          fillColor: context.isDark
                              ? textFormFieldFillColorBlack
                              : Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: context.isDark
                                ? BorderSide.none
                                : BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      const SpaceHeight(),
                      if (context.read<GeolocationCubit>().searchResults ==
                          null)
                        const Center(
                            child: CircularProgressIndicator.adaptive()),
                      Expanded(
                          child: context
                                  .read<GeolocationCubit>()
                                  .searchResults!
                                  .isEmpty
                              ? Center(
                                  child: Text(
                                      state.status == ActionStatus.isError
                                          ? "Hech qanday natija topilmadi".tr()
                                          : ''),
                                )
                              : ListView.builder(
                                  itemCount: context
                                      .read<GeolocationCubit>()
                                      .searchResults
                                      ?.length,
                                  padding: const EdgeInsets.all(10.0),
                                  itemBuilder: (context, index) {
                                    var placemark = state.positionList[index];
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // storage ga location ni statusini yozish kerak
                                            // StorageRepository.putInt(
                                            //     Keys.locationStatus, 2);
                                            context
                                                .read<GeolocationCubit>()
                                                .saveLocationChoice(placemark);
                                            context
                                                .read<NamozTimeBloc>()
                                                .add(TodayNamozTimes());
                                            widget.pageController.nextPage(
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.ease);

                                            state.positionList.clear();
                                            setState(() {});
                                            Navigator.pop(context);
                                            _controller.clear();
                                          },
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                AppIcon.location,
                                                width: 24.w,
                                                color: smallTextColor,
                                              ),
                                              const SpaceWidth(),
                                              const SpaceWidth(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    placemark.country!,
                                                    style: const TextStyle(
                                                      fontSize:
                                                          AppSizes.size_16,
                                                      fontWeight:
                                                          AppFontWeight.w_400,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    placemark.region!,
                                                    style: const TextStyle(
                                                      fontSize:
                                                          AppSizes.size_16,
                                                      fontWeight:
                                                          AppFontWeight.w_400,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SpaceHeight(),
                                        const Divider()
                                      ],
                                    );
                                  }))
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void searchRegion(String text) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<GeolocationCubit>().searchRegionByTitle(_controller.text);
    });
  }
}
