import 'package:flutter_compass/flutter_compass.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/service/qibla_service.dart';

part 'qibla_state.dart';

class QiblaCubit extends Cubit<QiblaState> {
  final QiblaService _qiblaService = QiblaService();
  QiblaCubit() : super(const QiblaState()) {
    // directionInfoStream();
  }
  Stream<DirectionInfo>? _directionInfoStream;

  double longitude = StorageRepository.getDouble(Keys.longitude);
  double latitude = StorageRepository.getDouble(Keys.latitude);

  Stream<DirectionInfo>? directionInfoStream() {
    debugPrint("$longitude LONG QIBLA");
    debugPrint("$latitude LAT QIBLA");
    _directionInfoStream = FlutterCompass.events?.map((event) {
      if (longitude.toString().isNotEmpty && latitude.toString().isNotEmpty) {
        return _qiblaService.getQiblaDirectionForLocation(
            event, latitude, longitude);
      } else {
        throw Error();
      }
    });
    return _directionInfoStream;
  }
}
