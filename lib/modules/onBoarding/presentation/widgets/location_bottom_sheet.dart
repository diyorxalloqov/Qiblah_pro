import 'dart:async';

import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

showLocationBottomSheet(BuildContext c) {
  showModalBottomSheet(
    isDismissible: false,
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
                          decoration: InputDecoration(
                            fillColor: context.isDark
                                ? textFormFieldFillColorBlack
                                : Colors.white,
                            filled: true,
                            prefixIcon: Icon(
                              Icons.search,
                              color: context.isDark
                                  ? const Color(0xffB5B9BC)
                                  : const Color(0xff6D7379),
                            ),
                            hintText: 'manzil'.tr(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          )),
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
                                  child: state.status == ActionStatus.isError
                                      ? Text(
                                          "Hech qanday natija topilmadi".tr())
                                      : const CircularProgressIndicator
                                          .adaptive(),
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
                                            context
                                                .read<GeolocationCubit>()
                                                .saveLocationChoice(placemark);
                                            context
                                                .read<GeolocationCubit>()
                                                .getChosenLocation();
                                            context
                                                .read<NamozTimeBloc>()
                                                .add(TodayNamozTimes());
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



// import 'dart:async';

// import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
// import 'package:qiblah_pro/modules/onBoarding/geolocation/geolocation/geolocation_cubit.dart';

// class UserInputLocationPage extends StatefulWidget {
//   final GeolocationCubit geolocationCubit;
//   const UserInputLocationPage({super.key, required this.geolocationCubit});

//   @override
//   State<UserInputLocationPage> createState() =>
//       _ManualPositionChooserRouteState();
// }

// class _ManualPositionChooserRouteState extends State<UserInputLocationPage> {
//   final TextEditingController _regionController = TextEditingController();

//   Timer? _debounce;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _debounce?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<GeolocationCubit, GeolocationState>(
//         bloc: widget.geolocationCubit,
//         builder: (context, state) {
//           return Column(
//             children: [
//               const SizedBox(height: 100),
//               TextField(
//                 autocorrect: false,
//                 controller: _regionController,
//                 keyboardType: TextInputType.text,
//                 onChanged: (text) {
//                   searchRegion(widget.geolocationCubit, text);
//                 },
//               ),
//               SizedBox(
//                 height: 250,
//                 child: resultList(widget.geolocationCubit),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget resultList(GeolocationCubit geolocationCubit) {
//     if (geolocationCubit.searchResults == null) {
//       return const SizedBox();
//     }

//     if (geolocationCubit.searchResults!.isEmpty) {
//       return Text('no regions were found');
//     }

//     return ListView.builder(
//       itemCount: geolocationCubit.searchResults?.length,
//       itemBuilder: (context, index) {
//         var placemark = geolocationCubit.searchResults![index];
//         return ListTile(
//           title: Text(placemark.region!),
//           subtitle: Text(placemark.country!),
//           onTap: () {
//             geolocationCubit.saveLocationChoice(placemark);
//             _navigateToPrayerTimes(context);
//           },
//         );
//       },
//     );
//   }

//   void _navigateToPrayerTimes(BuildContext context) {
//     // context.replace(TodayPrayerTimesRoute.route);
//   }

//   void searchRegion(GeolocationCubit geolocationCubit, String text) {
//     if (_debounce?.isActive ?? false) _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () {
//       geolocationCubit.searchRegionByTitle(_regionController.text);
//     });
//   }
// }
