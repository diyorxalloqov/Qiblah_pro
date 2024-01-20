import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class RouteList {
  static final RouteList _generate = RouteList._init();
  static RouteList get router => _generate;

  RouteList._init();

  Route? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _navigate(const SplashPage());
      case 'onBoarding':
        return _navigate(const OnBoarding());
      case 'login':
        return _navigate(const LoginPage());
      case 'register':
        return _navigate(const RegisterPage());
      case "bottomNavbar":
        return _navigate(const BottomNavbar());
      case "editProfile":
        return _navigate(
            EditProfilePage(profileBloc: settings.arguments as ProfileBloc));
    }
    return null;
  }

  _navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }

  // SecondPage(data: settings.arguments as UserModel)
}
