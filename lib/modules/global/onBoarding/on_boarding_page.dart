import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<String> _images = const [
    AppImages.person,
    AppImages.location,
    AppImages.notification
  ];

  final List<String> _titles = const [
    "Assalomu alaykum",
    "Joylashuv",
    "Bildirishnomalar"
  ];

  final List<String> _subtitles = const [
    "Ummat uchun tayyorlangan - super ilova",
    "Namoz vaqtlari va Qibla tomonni topish funksiyasi aniq ishlashi uchun ilova joylashuvingizni topishiga ruxsat berishingiz lozim",
    "Namoz vaqtlari o’tkazib yubormaslik uchun bildirishnomalarga ruxsat berishingiz lozim"
  ];

  final List<String> _buttonName = const [
    "Bismillah",
    "Davom etish",
    "Davom etish"
  ];

  final List<String> _textButtonName = const [
    "Tilni o’zgartirish",
    "Qo’lda sozlayman",
    "Bildirishnomalar kerak emas"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 30.h),
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
                    HighText(text: _titles[index]),
                    const SpaceHeight(),
                    Text(
                      _subtitles[index],
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
                                    child:
                                        Icon(Icons.check, color: primaryColor),
                                  ),
                                  const SpaceWidth(),
                                  const Text(
                                    "Namoz o’rganish va vaqtlari",
                                    style: TextStyle(
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
                                    child:
                                        Icon(Icons.check, color: primaryColor),
                                  ),
                                  const SpaceWidth(),
                                  const Text(
                                    "Qur’on tilovati va zikrlar",
                                    style: TextStyle(
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
                                    child:
                                        Icon(Icons.check, color: primaryColor),
                                  ),
                                  const SpaceWidth(),
                                  const Text(
                                    "Qibla va Duolar",
                                    style: TextStyle(
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
                                    pageController: _pageController))
                            : _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.bounceIn);
                        if (_currentPage == 2) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'register', (route) => false);
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
                            _buttonName[index],
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
                            onPressed: () {},
                            child: Text(
                              _textButtonName[index],
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
        controller: _pageController,
        itemCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (int value) {
          setState(() {
            _currentPage = value;
          });
        },
      ),
    );
  }
}
