import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String routeName = StorageRepository.getBool(Keys.isOnboarding) == true
      ? StorageRepository.getString(Keys.token).isEmpty
          ? 'register'
          : 'bottomNavbar'
      : 'onBoarding';

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) =>
        Navigator.pushNamedAndRemoveUntil(
            context, routeName, (route) => false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDark ? const Color(0xff1E2125) : primaryColor,
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.splash_back), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppIcon.appLogo, width: 90),
              SizedBox(height: 20.h),
              Text(
                'Qiblah',
                style: TextStyle(
                    fontSize: AppSizes.size_24,
                    fontWeight: AppFontWeight.w_600,
                    fontFamily: AppfontFamily.comforta.fontFamily,
                    color: Colors.white),
              ),
              SizedBox(height: 4.h),
              Text(
                "splash_desc".tr(),
                style: TextStyle(
                    fontSize: AppSizes.size_18,
                    color: Colors.white,
                    fontFamily: AppfontFamily.comforta.fontFamily),
              )
            ],
          ),
        ),
      )),
    );
  }
}
