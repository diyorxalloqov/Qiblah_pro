import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/ui/pages/quron/categories/category_details_pages/juzlar_details_page.dart';
// import 'package:qiblah_pro/modules/onBoarding/geolocation/auto_detect_page.dart';

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
      case 'detailPage':
        return _navigate(const AllFunctionPage());
      case 'newsDetail':
        return _navigate(const NewsDetailPage());
      case 'learnNamozPage':
        return _navigate(const LearnNamoz());
      case 'namozSectionScreen':
        return _navigate(const NamozSectionScreen());
      case 'TimePage':
        return _navigate(const TimePage());
      case 'taqvimPage':
        return _navigate(const TaqvimPage());
      case 'quronPage':
        return _navigate(const QuronPage());
      case 'suralarDetails':
        final args = settings.arguments as SuralarDetailsPageArguments;
        return _navigate(SuralarDetailsPage(data: args));
      case "juzlarDetails":
        final args = settings.arguments as JuzlarDetailsArgument;
        return _navigate(JuzlarDetailsPage(data: args));
    }
    return null;
  }

  _navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }

  // SecondPage(data: settings.arguments as UserModel)
}
