import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/onBoarding/bloc/on_boarding_bloc.dart';
import 'package:qiblah_pro/modules/onBoarding/presentation/widgets/lang_bottom_sheet.dart';
import 'package:qiblah_pro/modules/onBoarding/presentation/widgets/location_bottom_sheet.dart';

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
    return BlocListener<OnBoardingBloc, OnBoardingState>(
      listener: (context, state) {
        print(state.isGarantedLocation);
        if (state.isGarantedLocation || state.isGarantedNotification) {
          pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.bounceIn);
        }
      },
      child: Scaffold(
        body: PageView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: RadialGradient(colors: [
                    Colors.green.shade100,
                    Colors.lightGreen.shade50,
                    Colors.green.shade50
                  ])),
                  child: Center(
                    child: Image.asset(_images[index]),
                  ),
                ),
                const Spacer(),
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 30.h),
                  height: context.height * 0.56,
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
                      Text(
                        _subtitles[index].tr(),
                        style: TextStyle(
                            color: const Color(0xff6D7379),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SpaceHeight(height: 30.h),
                      _currentPage == 0
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.teal.shade100,
                                      radius: 20.r,
                                      child: Icon(Icons.check,
                                          color: primaryColor),
                                    ),
                                    const SpaceWidth(),
                                    Text(
                                      "namoz_organish_vaqtlari".tr(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SpaceHeight(height: 20.h),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.teal.shade100,
                                      radius: 20.r,
                                      child: Icon(Icons.check,
                                          color: primaryColor),
                                    ),
                                    const SpaceWidth(),
                                    Text(
                                      "Quron_tilovati_zikrlar".tr(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SpaceHeight(height: 20.h),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.teal.shade100,
                                      radius: 20.r,
                                      child: Icon(Icons.check,
                                          color: primaryColor),
                                    ),
                                    const SpaceWidth(),
                                    Text(
                                      "qibla_duolar".tr(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          _currentPage == 0
                              ? showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  isDismissible: false,
                                  builder: (context) => BottomSheetWidget(
                                      pageController: pageController))
                              : null;
                          if (_currentPage == 2) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, 'register', (route) => false);
                          }
                          print(_currentPage);
                          if (_currentPage == 1) {
                            context
                                .read<OnBoardingBloc>()
                                .add(LocationPermissionEvent());
                          }
                          if (_currentPage == 2) {
                            context
                                .read<OnBoardingBloc>()
                                .add(NotificationPermissionEvent());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            fixedSize: Size(double.infinity, 50.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox.shrink(),
                            Text(
                              _buttonName[index].tr(),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
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
                              onPressed: () {
                                _currentPage == 0
                                    ? showLangBottomSheet(context)
                                    : null;
                                _currentPage == 1
                                    ? showLocationBottomSheet(context)
                                    : Navigator.pushNamedAndRemoveUntil(
                                        context, 'register', (route) => false);
                              },
                              child: Text(
                                _textButtonName[index].tr(),
                                style: TextStyle(
                                    color: _currentPage == 0
                                        ? Colors.black
                                        : primaryColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      )
                    ],
                  ),
                )
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
