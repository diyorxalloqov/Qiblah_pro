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
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.appLogo), fit: BoxFit.cover)),
      )),
    );
  }
}
