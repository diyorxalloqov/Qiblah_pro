import 'package:qiblah_pro/core/db/shared_preferences.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

final serviceLocator = GetIt.I;

Future<void> setupLocator() async {
  StorageRepository.getInstance();
  serviceLocator.registerLazySingleton(DioSettings.new);
}
