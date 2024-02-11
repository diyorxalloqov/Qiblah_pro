import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/service/notification_service.dart';

final serviceLocator = GetIt.I;

Future<void> setupLocator() async {
  StorageRepository.getInstance();
  await NotificationServices().init();
  serviceLocator.registerLazySingleton(DioSettings.new);
  await EasyLocalization.ensureInitialized();
}
