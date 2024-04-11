import 'package:permission_handler/permission_handler.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/service/notification_service.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final List<String> _images = const [
    AppImages.person,
    AppImages.location,
    AppImages.notification,
    AppImages.reklama
  ];

  final List<String> _titles = const [
    "assalom_alekum",
    "joylashuv",
    "bildirishnomalar",
    "reklama"
  ];

  final List<String> _subtitles = [
    "app_highlight",
    "joylashuv_promt",
    "bildirishnoma_promt",
    "reklama_promt"
  ];

  final List<String> _buttonName = [
    "bismillah",
    "btn_davom_etish",
    "btn_davom_etish",
    "premiumni_yoqish"
  ];

  final List<String> _textButtonName = [
    "tilni_ozgartirish",
    "qolda_sozlayman",
    "bildirishnoma_kerakmas",
    "reklama_bilan_foydalanaman"
  ];
  String selectedLang = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, index) {
          return _currentPage == 1
              ? AutoChoiceLocation(pageController: pageController)
              : SingleChildScrollView(
                  child: Container(
                      height: context.height,
                      width: context.width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: context.isDark
                                  ? Alignment.topRight
                                  : Alignment.centerLeft,
                              end: context.isDark
                                  ? Alignment.bottomLeft
                                  : Alignment.bottomRight,
                              colors: context.isDark
                                  ? onBoardingBlack
                                  : onBoardingColor)),
                      child: Column(
                        children: [
                          Center(child: Image.asset(_images[index])),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 12.w, right: 12.w, top: 30.h),
                              decoration: BoxDecoration(
                                color: context.isDark
                                    ? bottomSheetBackgroundBlackColor
                                    : bottomSheetBackgroundColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    topRight: Radius.circular(18)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HighText(text: _titles[index].tr()),
                                  SpaceHeight(height: 18.h),
                                  Text(_subtitles[index].tr(),
                                      style: AppfontFamily.inter.copyWith(
                                          color: smallTextColor,
                                          fontSize: he(AppSizes.size_16),
                                          fontWeight: AppFontWeight.w_400)),
                                  _currentPage == 3
                                      ? Text(
                                          'reklama_promt1'.tr(),
                                          style: TextStyle(
                                              fontFamily: AppfontFamily
                                                  .inter.fontFamily,
                                              color: smallTextColor,
                                              fontSize: he(AppSizes.size_16),
                                              fontWeight: AppFontWeight.w_600),
                                        )
                                      : const SizedBox.shrink(),
                                  SpaceHeight(height: 18.h),
                                  _currentPage == 0
                                      ? Column(
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: context
                                                            .isDark
                                                        ? const Color(
                                                            0xff232C37)
                                                        : Colors.teal.shade100,
                                                    radius: 14.r,
                                                    child: Icon(Icons.check,
                                                        color: primaryColor,
                                                        size: 15.w)),
                                                const SpaceWidth(),
                                                Text(
                                                  "highlight_text_1".tr(),
                                                  style: AppfontFamily.inter
                                                      .copyWith(
                                                    fontSize:
                                                        he(AppSizes.size_15),
                                                    fontWeight:
                                                        AppFontWeight.w_500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SpaceHeight(height: 20.h),
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: context
                                                          .isDark
                                                      ? const Color(0xff232C37)
                                                      : Colors.teal.shade100,
                                                  radius: 14.r,
                                                  child: Icon(Icons.check,
                                                      color: primaryColor,
                                                      size: 15.w),
                                                ),
                                                const SpaceWidth(),
                                                Text(
                                                  "highlight_text_2".tr(),
                                                  style: AppfontFamily.inter
                                                      .copyWith(
                                                          fontSize: he(
                                                              AppSizes.size_15),
                                                          fontWeight:
                                                              AppFontWeight
                                                                  .w_500),
                                                ),
                                              ],
                                            ),
                                            SpaceHeight(height: 20.h),
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: context
                                                          .isDark
                                                      ? const Color(0xff232C37)
                                                      : Colors.teal.shade100,
                                                  radius: 14.r,
                                                  child: Icon(Icons.check,
                                                      color: primaryColor,
                                                      size: 15.w),
                                                ),
                                                const SpaceWidth(),
                                                Text(
                                                  "highlight_text_3".tr(),
                                                  style: AppfontFamily.inter
                                                      .copyWith(
                                                    fontSize:
                                                        he(AppSizes.size_15),
                                                    fontWeight:
                                                        AppFontWeight.w_500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                  const Spacer(),
                                  ElevatedButton(
                                    onPressed: () async {
                                      _currentPage == 0
                                          ? showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              isDismissible: true,
                                              builder: (context) =>
                                                  BottomSheetWidget(
                                                      pageController:
                                                          pageController))
                                          : null;
                                      if (_currentPage == 2) {
                                        bool isPermissionGranted =
                                            await NotificationServices().init();
                                        if (isPermissionGranted) {
                                          pageController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeIn);
                                          context.read<NamozTimeBloc>().add(
                                                const ScheduleNotificationEvent(
                                                    namoz: NamozEnum.all),
                                              );
                                          StorageRepository.putBool(
                                              Keys.notification,
                                              isPermissionGranted);
                                        }
                                        if (!isPermissionGranted) {
                                          openAppSettings();
                                        }
                                        await StorageRepository.putBool(
                                            Keys.isOnboarding, true);
                                      } else if (_currentPage == 3) {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                'premiumScreen',
                                                (route) => false);
                                        await StorageRepository.putBool(
                                            Keys.isOnboarding, true);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                        fixedSize: Size(double.infinity, 50.h),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.r))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox.shrink(),
                                        Text(
                                          _buttonName[index].tr(),
                                          style: AppfontFamily.inter.copyWith(
                                            fontSize: AppSizes.size_16,
                                            color: buttonNameColor,
                                            fontWeight: AppFontWeight.w_600,
                                          ),
                                        ),
                                        SvgPicture.asset(AppIcon.arrowRight)
                                      ],
                                    ),
                                  ),
                                  const SpaceHeight(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _currentPage == 0
                                          ? SvgPicture.asset(
                                              AppIcon.localization)
                                          : SizedBox.fromSize(),
                                      TextButton(
                                          onPressed: () async {
                                            debugPrint(_currentPage.toString());
                                            _currentPage == 0
                                                ? showModalBottomSheet(
                                                    context: context,
                                                    isDismissible: true,
                                                    isScrollControlled: true,
                                                    builder: (c) =>
                                                        lang(context))
                                                : null;
                                            if (_currentPage == 2) {
                                              pageController.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeIn);
                                            } else if (_currentPage == 3) {
                                              Future.delayed(Duration.zero)
                                                  .then((value) => Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          'register',
                                                          (route) => false,
                                                          arguments: true));
                                              await StorageRepository.putBool(
                                                  Keys.isOnboarding, true);
                                            }
                                          },
                                          child: Text(
                                            _textButtonName[index].tr(),
                                            style: TextStyle(
                                                color: _currentPage == 0
                                                    ? context.isDark
                                                        ? Colors.white
                                                        : Colors.black
                                                    : primaryColor,
                                                fontSize: AppSizes.size_16,
                                                fontWeight:
                                                    AppFontWeight.w_600),
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 12.h)
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                );
        },
        controller: pageController,
        itemCount: 4,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (int value) {
          setState(() {
            _currentPage = value;
          });
        },
      ),
    );
  }

  // language bottomsheet

  Column lang(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 25.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: MediumText(text: 'tilni_ozgartirish'.tr()),
        ),
        Container(
          color: context.isDark
              ? bottomSheetBackgroundBlackColor
              : bottomSheetBackgroundColor,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(12.0),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: selectedLang == 'uz'
                      ? primaryColor.withOpacity(0.2)
                      : context.isDark
                          ? textFormFieldFillColorBlack
                          : Colors.white,
                ),
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      selectedLang = 'uz';
                      context.setLocale(const Locale('uz'));
                    });
                    await StorageRepository.putString(Keys.lang, selectedLang);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "O'zbekcha",
                    style: AppfontFamily.inter.copyWith(
                      color: selectedLang == 'uz'
                          ? primaryColor
                          : context.isDark
                              ? Colors.white
                              : Colors.black,
                      fontSize: AppSizes.size_16,
                      fontWeight: AppFontWeight.w_500,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(12.0),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: selectedLang == 'ru'
                      ? primaryColor.withOpacity(0.2)
                      : context.isDark
                          ? textFormFieldFillColorBlack
                          : Colors.white,
                ),
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      selectedLang = 'ru';
                      context.setLocale(const Locale('ru'));

                      Navigator.pop(context);
                    });
                    await StorageRepository.putString(Keys.lang, selectedLang);
                  },
                  child: Text(
                    "Ruscha",
                    style: AppfontFamily.inter.copyWith(
                      color: selectedLang == 'ru'
                          ? primaryColor
                          : context.isDark
                              ? Colors.white
                              : Colors.black,
                      fontSize: AppSizes.size_16,
                      fontWeight: AppFontWeight.w_500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
