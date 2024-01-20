import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

final serviceLocator = GetIt.I;

Future<void> setupLocator() async {
  serviceLocator.registerLazySingleton(DioSettings.new);
}
