import 'dart:async';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

showLocationBottomSheet(BuildContext c) {
  showModalBottomSheet(
    isDismissible: true,
    context: c,
    isScrollControlled: true,
    builder: (c) => const LocationBottomSheet(),
  );
}

class LocationBottomSheet extends StatefulWidget {
  const LocationBottomSheet({Key? key}) : super(key: key);

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
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
    return Container(
      decoration: BoxDecoration(
          color: context.isDark
              ? bottomSheetBackgroundBlackColor
              : bottomSheetBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r))),
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
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
              child: Column(
                children: [
                  TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'manzil_prop'.tr();
                        }
                        return '';
                      },
                      // onChanged: (v) {
                      //   if (v.isEmpty) {
                      //     state.positionList.clear();
                      //     setState(() {});
                      //   }
                      //   return searchRegion(v);
                      // },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(2.0),
                        fillColor: context.isDark
                            ? textFormFieldFillColorBlack
                            : Colors.white,
                        filled: true,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              if (_controller.text.isNotEmpty) {
                                print('salom');
                                context
                                    .read<GeolocationCubit>()
                                    .searchRegionByTitle(_controller.text);
                              } else {
                                showToastMessage(
                                    "validator_prop".tr(), context);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: wi(20), vertical: he(10)),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(10.r)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 5),
                              child:
                                  const Icon(Icons.search, color: Colors.white),
                            )),
                        prefixIcon: Icon(
                          Icons.search,
                          color: context.isDark
                              ? const Color(0xffB5B9BC)
                              : const Color(0xff6D7379),
                        ),
                        hintText: 'manzil'.tr(),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade300, width: 1),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        enabled: true,
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade300, width: 1),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade300, width: 1),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade300, width: 1),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade300, width: 1),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      )),
                  const SpaceHeight(),
                  BlocBuilder<GeolocationCubit, GeolocationState>(
                    builder: (context, state) {
                      if (state.manualStatus == ActionStatus.isLoading) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      }
                      if (state.manualStatus == ActionStatus.isSuccess) {
                        return Expanded(
                            child: ListView.builder(
                                itemCount:
                                    state.manualChoserModel?.features?.length,
                                padding: const EdgeInsets.all(10.0),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          context
                                              .read<GeolocationCubit>()
                                              .saveLocationManual(
                                                  state.manualChoserModel,
                                                  index);
                                          context
                                              .read<NamozTimeBloc>()
                                              .add(TodayNamozTimes());
                                          setState(() {});
                                          Navigator.pop(context);
                                          _controller.clear();
                                          await StorageRepository.putString(
                                              Keys.locationStatus, '2');
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
                                                  state
                                                          .manualChoserModel
                                                          ?.features?[index]
                                                          .properties
                                                          ?.country ??
                                                      '',
                                                  style: const TextStyle(
                                                    fontSize: AppSizes.size_16,
                                                    fontWeight:
                                                        AppFontWeight.w_400,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  state
                                                          .manualChoserModel
                                                          ?.features?[index]
                                                          .properties
                                                          ?.city ??
                                                      '',
                                                  style: const TextStyle(
                                                    fontSize: AppSizes.size_16,
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
                                }));
                      } else if (state.manualStatus == ActionStatus.isError) {
                        return Center(child: Text("natija".tr()));
                      }
                      return const SizedBox.shrink();
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void searchRegion(String text) {
  //   if (_debounce?.isActive ?? false) _debounce?.cancel();
  //   _debounce = Timer(const Duration(milliseconds: 200), () {
  //     context.read<GeolocationCubit>().searchRegionByTitle(text);
  //   });
  // }
}
