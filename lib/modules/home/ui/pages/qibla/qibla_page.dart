import 'dart:math';

import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/blocs/qibla/qibla_cubit.dart';
import 'package:qiblah_pro/modules/home/ui/pages/qibla/google_map.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> with WidgetsBindingObserver {
  late GeolocationCubit geolocationCubit;
  late QiblaCubit qiblaCubit;

  @override
  void initState() {
    qiblaCubit = QiblaCubit();
    geolocationCubit = GeolocationCubit();
    super.initState();
    geolocationCubit.requirePreciseLocation = false;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // final GeolocationCubit geolocationbloc =
      //     BlocProvider.of<GeolocationCubit>(context, listen: false);
      // This widget has been unmounted, so the State no longer has a context (and should be considered defunct).
      if (geolocationCubit.isWaitingForPermission) {
        geolocationCubit.determineLocation();
        geolocationCubit.stopWaitingForPermission();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: qiblaCubit,
      child: Scaffold(
          appBar: customAppbar(context, 'qibla'.tr()),
          body: Column(
            children: [
              Expanded(
                child: SizedBox(
                  height: context.height * 0.4,
                  child: const SmallGoogleMap(),
                ),
              ),
              SpaceHeight(height: context.height * 0.05),
              Expanded(
                child: BlocBuilder<GeolocationCubit, GeolocationState>(
                  bloc: geolocationCubit,
                  builder: (context, state) {
                    return findAprWidgetByLocationInfo(geolocationCubit);
                  },
                ),
              ),
            ],
          )),
    );
  }

  findAprWidgetByLocationInfo(GeolocationCubit cubit) {
    print(cubit.locationInfo.locationStatus);
    switch (cubit.locationInfo.locationStatus) {
      case LocationStatusEnum.failed:
        return failedCase(cubit);
      case LocationStatusEnum.notRequested:
        cubit.determineLocation();
        return notRequested(cubit);
      case LocationStatusEnum.waiting:
        return waitingForLocation(cubit.locationInfo);
      case LocationStatusEnum.denied:
        return noPermission(cubit);
      case LocationStatusEnum.deniedForever:
        return deniedForever(cubit);
      case LocationStatusEnum.gpsDisabled:
        return gpsDisabled(cubit);
      case LocationStatusEnum.onlyApproximate:
        return determinedLocation(cubit);
      case LocationStatusEnum.available:
        return determinedLocation(cubit);
    }
  }

  Widget determinedLocation(GeolocationCubit cubit) {
    cubit.addAddressInfo(cubit.locationInfo.position).then((data) {
      print('$data snapshot data');

      if (data != null) {
        // Data is available, process it
        print("$data snapshot data is");
        cubit.saveLocationChoice(data);
      }
    }).catchError((error) {
      print('Error: $error');
    });

    // Return an empty SizedBox as a placeholder
    return _buildCompass();
  }

  Widget _buildCompass() {
    return StreamBuilder<DirectionInfo>(
      stream: qiblaCubit.directionInfoStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data!.heading;

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null) {
          return const Center(
            child: Text("Device does not have sensors !"),
          );
        }

        return Column(
          children: [
            Transform.rotate(
                angle: (snapshot.data!.qiblahDirection * (pi / 180) * -1),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.5), width: 1)),
                      child: Center(
                        child: SvgPicture.asset(AppIcon.qibla),
                      ),
                    ),
                    const SpaceHeight(),
                    const SpaceHeight(),
                    Image.asset(AppImages.qibla_direction),
                  ],
                )),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  color:
                      context.isDark ? const Color(0xff232C37) : Colors.white,
                  borderRadius: BorderRadius.circular(24.r)),
              child: Column(
                children: [
                  Text(
                    'sizning_joylashuvingiz'.tr(),
                    style: TextStyle(
                        fontSize: AppSizes.size_14,
                        fontFamily: AppfontFamily.comforta.fontFamily,
                        fontWeight: AppFontWeight.w_700),
                  ),
                  const SizedBox(height: 4),
                  FutureBuilder(
                      future:
                          context.read<GeolocationCubit>().getChosenLocation(),
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data?.region.toString() ?? 'not found',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: AppSizes.size_12,
                            fontFamily: AppfontFamily.inter.fontFamily,
                            fontWeight: AppFontWeight.w_400,
                          ),
                        );
                      }),
                ],
              ),
            ),
            SpaceHeight(height: context.bottom + 40)
          ],
        );
      },
    );
  }

  // Widget locationAvailable(PositionInfo positionInfo) {
  //   return BlocBuilder<QiblaCubit, QiblaState>(
  //     builder: (context, state) {
  //       return Column(children: [
  //         _buildManualReader(),
  //         Flexible(child: _buildCompass()),
  //       ]);
  //     },
  //   );
  // }

  // Widget _buildManualReader() {
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Row(
  //       children: <Widget>[
  //         ElevatedButton(
  //           child: Text('Read Value'),
  //           onPressed: () async {
  //             final CompassEvent tmp = await FlutterCompass.events!.first;
  //             setState(() {
  //               _lastRead = tmp;
  //               _lastReadAt = DateTime.now();
  //             });
  //           },
  //         ),
  //         Expanded(
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Text(
  //                   '$_lastRead',
  //                   style: Theme.of(context).textTheme.bodySmall,
  //                 ),
  //                 Text(
  //                   '$_lastReadAt',
  //                   style: Theme.of(context).textTheme.bodySmall,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget notPrecise(GeolocationCubit cubit) {
    // TODO compassni asosi, bor lekin strelkalari va qutb yozuvlari yo'q tasvir ko'rsatiladi
    // Yoki strelka tinimsiz bir yo'nalishda aylanaveradi yoki bir u tomonga bir bu tomonga aylanavarib aniq
    // topolmayotganini tushuntiradi
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
            'you choose approximate location, however we need precise location'),
        ElevatedButton(
            onPressed: () {
              cubit.askToIncreaseAccuracy();
            },
            child: const Text('Increase accuracy')),
      ],
    );
  }

  Widget notRequested(GeolocationCubit cubit) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.5), width: 1)),
              child: Center(
                child: SvgPicture.asset(AppIcon.qibla),
              ),
            ),
            const SpaceHeight(),
            const SpaceHeight(),
            Image.asset(AppImages.qibla_direction),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              color: context.isDark ? const Color(0xff232C37) : Colors.white,
              borderRadius: BorderRadius.circular(24.r)),
          child: Column(
            children: [
              Text(
                'sizning_joylashuvingiz'.tr(),
                style: TextStyle(
                    fontSize: AppSizes.size_14,
                    fontFamily: AppfontFamily.comforta.fontFamily,
                    fontWeight: AppFontWeight.w_700),
              ),
              const SizedBox(height: 4),
              FutureBuilder(
                  future: context.read<GeolocationCubit>().getChosenLocation(),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data?.region.toString() ?? 'not found',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: AppSizes.size_12,
                        fontFamily: AppfontFamily.inter.fontFamily,
                        fontWeight: AppFontWeight.w_400,
                      ),
                    );
                  }),
            ],
          ),
        ),
        SpaceHeight(height: context.bottom + 40)
      ],
    );
  }

  Widget waitingForLocation(LocationInfo locationInfo) {
    // TODO alohida metod o'rniga button loading spinnerga aylanishinini ko'rsatish
    return Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor.withOpacity(0.2)),
        strokeWidth: 13,
        strokeAlign: 2,
      ),
    );
  }

  Widget gpsDisabled(GeolocationCubit cubit) {
    // TODO GPS o'chiqligni ko'rsatish
    return Column(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.5), width: 1)),
              child: Center(
                child: SvgPicture.asset(AppIcon.qibla),
              ),
            ),
            const SpaceHeight(),
            const SpaceHeight(),
            Image.asset(AppImages.qibla_direction),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => cubit.askToEnableGPS(),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(24.r)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'iltimos_gps_yoqing'.tr(),
                  style: TextStyle(
                      fontSize: AppSizes.size_14,
                      fontFamily: AppfontFamily.comforta.fontFamily,
                      fontWeight: AppFontWeight.w_700),
                ),
                const SpaceWidth(),
                SvgPicture.asset(AppIcon.arrowRight, color: Colors.black)
              ],
            ),
          ),
        ),
        SpaceHeight(height: context.bottom + 40)
      ],
    );
  }

  Widget noPermission(GeolocationCubit cubit) {
    // TODO permission yo'qligini ko'rsatish
    return Column(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.5), width: 1)),
              child: Center(
                child: SvgPicture.asset(AppIcon.qibla),
              ),
            ),
            const SpaceHeight(),
            const SpaceHeight(),
            Image.asset(AppImages.qibla_direction),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => cubit.askToEnableGPS(),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(24.r)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'gps_ruxsat_berish'.tr(),
                  style: TextStyle(
                      fontSize: AppSizes.size_14,
                      fontFamily: AppfontFamily.comforta.fontFamily,
                      fontWeight: AppFontWeight.w_700),
                ),
                const SpaceWidth(),
                SvgPicture.asset(AppIcon.arrowRight, color: Colors.black)
              ],
            ),
          ),
        ),
        SpaceHeight(height: context.bottom + 40)
      ],
    );
  }

  Widget deniedForever(GeolocationCubit cubit) {
    // TODO Nastorykadan yoqish kerakligni tushuntiradigan rasm yoki nimadir Widget
    return Column(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.5), width: 1)),
              child: Center(
                child: SvgPicture.asset(AppIcon.qibla),
              ),
            ),
            const SpaceHeight(),
            const SpaceHeight(),
            Image.asset(AppImages.qibla_direction),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => cubit.askToEnableGPS(),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(24.r)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'gps_ruxsat_berish'.tr(),
                  style: TextStyle(
                      fontSize: AppSizes.size_14,
                      fontFamily: AppfontFamily.comforta.fontFamily,
                      fontWeight: AppFontWeight.w_700),
                ),
                const SpaceWidth(),
                SvgPicture.asset(AppIcon.arrowRight, color: Colors.black)
              ],
            ),
          ),
        ),
        SpaceHeight(height: context.bottom + 40)
      ],
    );
  }

  Widget failedCase(GeolocationCubit cubit) {
    // TODO something went wrong

    return Column(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.5), width: 1)),
              child: Center(
                child: SvgPicture.asset(AppIcon.qibla),
              ),
            ),
            const SpaceHeight(),
            const SpaceHeight(),
            Image.asset(AppImages.qibla_direction),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => cubit.askToEnableGPS(),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(24.r)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'aniqlanmadi'.tr(),
                  style: TextStyle(
                      fontSize: AppSizes.size_14,
                      fontFamily: AppfontFamily.comforta.fontFamily,
                      fontWeight: AppFontWeight.w_700),
                ),
                const SpaceWidth(),
                SvgPicture.asset(AppIcon.arrowRight, color: Colors.black)
              ],
            ),
          ),
        ),
        SpaceHeight(height: context.bottom + 40)
      ],
    );
  }
}
