
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

final serviceLocator = GetIt.I;

Future<void> setupLocator() async {
  await StorageRepository.getInstance();
  serviceLocator.registerLazySingleton(DioSettings.new);
  await EasyLocalization.ensureInitialized();
  await MobileAds.instance.initialize();
}
