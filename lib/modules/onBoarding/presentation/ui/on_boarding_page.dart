import 'package:qiblah_pro/core/db/shared_preferences.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

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
    AppImages.notification
  ];

  final List<String> _titles = const [
    "assalom_alekum",
    "joylashuv",
    "bildirishnomalar"
  ];

  final List<String> _subtitles = [
    "app_highlight",
    "joylashuv_promt",
    "bildirishnoma_promt"
  ];

  final List<String> _buttonName = [
    "bismillah",
    "btn_davom_etish",
    "btn_davom_etish"
  ];

  final List<String> _textButtonName = [
    "tilni_ozgartirish",
    "qolda_sozlayman",
    "bildirishnoma_kerakmas"
  ];

  @override
  Widget build(BuildContext context) {
    bool size = context.height >= 800 ? true : false;

    return BlocListener<OnBoardingBloc, OnBoardingState>(
      listener: (context, state) {
        if (state.isGarantedLocation) {
          pageController.nextPage(
              duration: const Duration(milliseconds: 1),
              curve: Curves.bounceIn);
        }
        print('hello ${state.isGarantedNotification}');
        if (state.isGarantedNotification) {
          print('Notification permission granted');
          print("${state.isGarantedNotification} notification");
          Navigator.of(context)
              .pushNamedAndRemoveUntil('register', (route) => false);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  // height: context.height * 0.9,
                  width: context.width,
                  decoration: const BoxDecoration(
                      // image: DecorationImage(
                      //     image: AssetImage(AppImages.gradient),
                      //     alignment: Alignment.centerLeft,
                      //     fit: BoxFit.cover)
                      gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xffE2F5DE),
                      Color(0xffDEF2E5),
                      Color(0xffECFAE1),
                    ],
                  )),
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset(_images[index]),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 30.h),
                        height: size
                            ? context.height * 0.59
                            : context.height * 0.56,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HighText(text: _titles[index].tr()),
                            const SpaceHeight(),
                            Text(_subtitles[index].tr(),
                                style: AppfontFamily.inter.copyWith(
                                    color: smallTextColor,
                                    fontSize: AppSizes.size_15,
                                    fontWeight: AppFontWeight.w_400)),
                            SpaceHeight(height: 30.h),
                            _currentPage == 0
                                ? Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor:
                                                  Colors.teal.shade100,
                                              radius: 20.r,
                                              child: Icon(Icons.check,
                                                  color: primaryColor)),
                                          const SpaceWidth(),
                                          Text(
                                            "namoz_organish_vaqtlari".tr(),
                                            style: AppfontFamily.inter.copyWith(
                                              fontSize: AppSizes.size_15,
                                              fontWeight: AppFontWeight.w_500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SpaceHeight(height: 20.h),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                Colors.teal.shade100,
                                            radius: 20.r,
                                            child: Icon(Icons.check,
                                                color: primaryColor),
                                          ),
                                          const SpaceWidth(),
                                          Text(
                                            "Quron_tilovati_zikrlar".tr(),
                                            style: AppfontFamily.inter.copyWith(
                                              fontSize: AppSizes.size_15,
                                              fontWeight: AppFontWeight.w_500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SpaceHeight(height: 20.h),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                Colors.teal.shade100,
                                            radius: 20.r,
                                            child: Icon(Icons.check,
                                                color: primaryColor),
                                          ),
                                          const SpaceWidth(),
                                          Text(
                                            "qibla_duolar".tr(),
                                            style: AppfontFamily.inter.copyWith(
                                              fontSize: AppSizes.size_15,
                                              fontWeight: AppFontWeight.w_500,
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
                                        isDismissible: false,
                                        builder: (context) => BottomSheetWidget(
                                            pageController: pageController))
                                    : null;

                                print(_currentPage);
                                if (_currentPage == 1) {
                                  context
                                      .read<OnBoardingBloc>()
                                      .add(LocationPermissionEvent());
                                }
                               else if (_currentPage == 2) {
                                  // print('page is $_currentPage');
                                  print(context.read<OnBoardingBloc>().state.isGarantedNotification);
                                  print('object');
                                  context
                                      .read<OnBoardingBloc>()
                                      .add(NotificationPermissionEvent());
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
                                    ? SvgPicture.asset(AppIcon.localization)
                                    : SizedBox.fromSize(),
                                TextButton(
                                    onPressed: () async {
                                      print(_currentPage);
                                      _currentPage == 0
                                          ? showLangBottomSheet(context)
                                          : null;
                                      _currentPage == 1
                                          ? showLocationBottomSheet(context)
                                          : null;
                                      if (_currentPage == 2) {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            'register',
                                            (route) => false);
                                        await StorageRepository.putBool(
                                            Keys.isOnboarding, true);
                                      }
                                    },
                                    child: Text(
                                      _textButtonName[index].tr(),
                                      style: TextStyle(
                                          color: _currentPage == 0
                                              ? Colors.black
                                              : primaryColor,
                                          fontSize: AppSizes.size_16,
                                          fontWeight: AppFontWeight.w_600),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          controller: pageController,
          itemCount: 3,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (int value) {
            setState(() {
              _currentPage = value;
            });
          },
        ),
      ),
    );
  }
}
