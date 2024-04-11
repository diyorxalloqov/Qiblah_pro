import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/premium/presentation/ui/premium_screen.dart';

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
      case 'newsDetail':
        return _navigate(const NewsDetailPage());
      case 'learnNamozPage':
        return _navigate(LearnNamoz(
            categoryItem: settings.arguments as List<CategoryItems>));
      case 'jamoatNamozi':
        return _navigate(JamoatNamozi(
            categoryItem: settings.arguments as List<CategoryItems>));
      case 'tahorat':
        return _navigate(LearnTahorat(
            categoryItem: settings.arguments as List<CategoryItems>));
      case 'mistakes':
        return _navigate(
            Mistakes(categoryItem: settings.arguments as List<CategoryItems>));
      case 'qoshimchalar':
        return _navigate(Qoshimchalar(
            categoryItem: settings.arguments as List<CategoryItems>));
      case 'TimePage':
        return _navigate(const TimePage());
      case 'taqvimPage':
        return _navigate(const TaqvimPage());
      case 'suralarDetails':
        final args = settings.arguments as SuralarDetailsPageArguments;
        return _navigate(SuralarDetailsPage(data: args));
      case "juzlarDetails":
        final args = settings.arguments as JuzlarDetailsArgument;
        return _navigate(JuzlarDetailsPage(data: args));
      case 'quron':
        return _navigate(const QuronPage());
      case "qibla":
        return _navigate(const QiblaPage());
      case "zikr":
        return _navigate(const ZikrPage());
      case "names":
        return _navigate(const NamesPage());
      case "qazo":
        return _navigate(const QazoPage());
      case 'zikrMain':
        return _navigate(
            ZikrMain(zikrArguments: settings.arguments as ZikrArguments));
      case "namesDetailsPage":
        final args = settings.arguments as NamesDetailsArgument;
        return _navigate(NamesDetailsPage(namesDetailsArgument: args));
      case 'tasbehPage':
        return _navigate(TasbehPage(
            zikrDetailsArgument: settings.arguments as ZikrDetailsArgument));
      case 'tasbehNamePage':
        return _navigate(TasbehNamePage(
            namesDetailsArgument: settings.arguments as NamesDetailsArgument));
      case 'premiumScreen':
        return _navigate(
            PremiumScreen(isOnboarding: settings.arguments as bool));
    }
    return null;
  }

  _navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }

  // SecondPage(data: settings.arguments as UserModel)
}
