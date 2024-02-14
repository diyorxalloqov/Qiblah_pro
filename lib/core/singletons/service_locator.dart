import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

final serviceLocator = GetIt.I;

Future<void> setupLocator() async {
  await StorageRepository.getInstance();
  // await Hive.initFlutter();
  serviceLocator.registerLazySingleton(DioSettings.new);
  await EasyLocalization.ensureInitialized();
}
