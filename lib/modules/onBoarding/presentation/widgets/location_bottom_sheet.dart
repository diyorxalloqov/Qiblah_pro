import 'dart:async';

import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/blocs/namoz_time/namoz_time_bloc.dart';
import 'package:qiblah_pro/modules/onBoarding/geolocation/cubit/geolocation_cubit.dart';

showLocationBottomSheet(BuildContext c) {
  showModalBottomSheet(
    isDismissible: false,
    context: c,
    isScrollControlled: true,
    builder: (c) => const LocationBottomSheet(),
  );
}

class LocationBottomSheet extends StatefulWidget {
  // final GeolocationCubit geolocationCubit;
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
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 25.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              child: MediumText(text: 'manzilni_qidirish'.tr()),
            ),
            Container(
              height: context.height * .7,
              color: bottomSheetBackgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      onChanged: (v) => searchRegion(v),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.search,
                            color: smallTextColor,
                          ),
                          hintText: 'manzil'.tr(),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.5))),
                    ),
                    const SpaceHeight(),
                    if (context.read<GeolocationCubit>().searchResults == null)
                      const SizedBox(),
                    Expanded(
                        child: context
                                .read<GeolocationCubit>()
                                .searchResults!
                                .isEmpty
                            ? Center(
                                child:
                                    Text("Hech qanday natija topilmadi".tr()),
                              )
                            : ListView.builder(
                                itemCount: context
                                    .read<GeolocationCubit>()
                                    .searchResults
                                    ?.length,
                                padding: const EdgeInsets.all(10.0),
                                itemBuilder: (context, index) {
                                  var placemark = context
                                      .read<GeolocationCubit>()
                                      .searchResults![index];
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          context
                                              .read<GeolocationCubit>()
                                              .saveLocationChoice(placemark);
                                          print(placemark.latitude);
                                          print(placemark.longitude);
                                          context
                                              .read<NamozTimeBloc>()
                                              .add(TodayNamozTimes());
                                          context
                                              .read<GeolocationCubit>()
                                              .searchResults
                                              ?.clear();
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
                                                    fontSize: AppSizes.size_16,
                                                    fontWeight:
                                                        AppFontWeight.w_400,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  placemark.region!,
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
                                }))
                  ],
                ),
              ),
            ),
          ],
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
