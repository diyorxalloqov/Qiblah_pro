import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/onBoarding/presentation/widgets/on_boarding_location_bottomsheet.dart';

class AutoChoiceLocation extends StatefulWidget {
  final PageController pageController;
  const AutoChoiceLocation({super.key, required this.pageController});

  @override
  State<AutoChoiceLocation> createState() =>
      _AutomaticPositionChooserRouteState();
}

class _AutomaticPositionChooserRouteState extends State<AutoChoiceLocation>
    with WidgetsBindingObserver {
  late GeolocationCubit geolocationCubit;

  @override
  void initState() {
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
      value: geolocationCubit,
      child: Scaffold(
          body: BlocBuilder<GeolocationCubit, GeolocationState>(
            bloc: geolocationCubit,
            builder: (context, state) {
              return findAprWidgetByLocationInfo(geolocationCubit);
            },
          )),
    );
  }

 Widget findAprWidgetByLocationInfo(GeolocationCubit cubit) {
    switch (cubit.locationInfo.locationStatus) {
      case LocationStatusEnum.failed:
        return failedCase(cubit);
      case LocationStatusEnum.notRequested:
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
        widget.pageController.nextPage(
            duration: const Duration(milliseconds: 1), curve: Curves.bounceIn);
        return determinedLocation(cubit);
      case LocationStatusEnum.available:
        widget.pageController.nextPage(
            duration: const Duration(milliseconds: 1), curve: Curves.bounceIn);
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
    return const SizedBox.shrink();
  }

  Widget notRequested(GeolocationCubit cubit) {
    return LocationPageWidget(
        onTap: () => cubit.determineLocation(),
        elevatedButtonShow: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox.shrink(),
            Text(
              "btn_davom_etish".tr(),
              style: AppfontFamily.inter.copyWith(
                fontSize: AppSizes.size_16,
                color: buttonNameColor,
                fontWeight: AppFontWeight.w_600,
              ),
            ),
            SvgPicture.asset(AppIcon.arrowRight)
          ],
        ),
        textButtonOnTap: () {
          _navigateToManualChooser(context);
        });
  }

  Widget waitingForLocation(LocationInfo locationInfo) {
    // TODO alohida metod o'rniga button loading spinnerga aylanishinini ko'rsatish
    return LocationPageWidget(
        onTap: () {},
        elevatedButtonShow: const Center(
          child:
              CircularProgressIndicator.adaptive(backgroundColor: Colors.white),
        ),
        textButtonOnTap: () {
          _navigateToManualChooser(context);
        });
  }

  Widget gpsDisabled(GeolocationCubit cubit) {
    // TODO GPS o'chiqligni ko'rsatish

    return LocationPageWidget(
        onTap: () => cubit.askToEnableGPS(),
        elevatedButtonShow: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox.shrink(),
            Text(
              "gps_ochiq_yoqish".tr(),
              style: AppfontFamily.inter.copyWith(
                fontSize: AppSizes.size_16,
                color: buttonNameColor,
                fontWeight: AppFontWeight.w_600,
              ),
            ),
            SvgPicture.asset(AppIcon.arrowRight)
          ],
        ),
        textButtonOnTap: () {
          _navigateToManualChooser(context);
        });
  }

  Widget noPermission(GeolocationCubit locationCubit) {
    // TODO permission yo'qligini ko'rsatish
    return LocationPageWidget(
        onTap: () => locationCubit.determineLocation(),
        elevatedButtonShow: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox.shrink(),
            Text(
              "gps_ruxsat_berish".tr(),
              style: AppfontFamily.inter.copyWith(
                fontSize: AppSizes.size_16,
                color: buttonNameColor,
                fontWeight: AppFontWeight.w_600,
              ),
            ),
            SvgPicture.asset(AppIcon.arrowRight)
          ],
        ),
        textButtonOnTap: () {
          _navigateToManualChooser(context);
        });
  }

  Widget deniedForever(GeolocationCubit locationCubit) {
    // TODO Nastorykadan yoqish kerakligni tushuntiradigan rasm yoki nimadir Widget
    return LocationPageWidget(
        onTap: () => locationCubit.askToGivePermissionsInSettings(),
        elevatedButtonShow: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox.shrink(),
            Text(
              "gps_ochiq_yoqish".tr(),
              style: TextStyle(
                fontSize: AppSizes.size_16,
                fontFamily: AppfontFamily.inter.fontFamily,
                color: buttonNameColor,
                fontWeight: AppFontWeight.w_600,
              ),
            ),
            SvgPicture.asset(AppIcon.arrowRight)
          ],
        ),
        textButtonOnTap: () {
          _navigateToManualChooser(context);
        });
  }

  Widget failedCase(GeolocationCubit locationCubit) {
    // TODO something went wrong

    return LocationPageWidget(
      onTap: () => locationCubit.determineLocation(),
      elevatedButtonShow: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox.shrink(),
          Text(
            "aniqlanmadi".tr(),
            style: TextStyle(
              fontSize: AppSizes.size_16,
              fontFamily: AppfontFamily.inter.fontFamily,
              color: buttonNameColor,
              fontWeight: AppFontWeight.w_600,
            ),
          ),
          SvgPicture.asset(AppIcon.arrowRight)
        ],
      ),
      textButtonOnTap: () async {
        _navigateToManualChooser(context);
      },
    );
  }

  void _navigateToManualChooser(BuildContext context) {
    /// bottom sheet bilan user tanlashi kerak
    showLocationBottomSheetOnBoarding(context, widget.pageController);
  }
}
