import 'package:qiblah_pro/modules/home/models/time_calculation_model.dart';
import 'package:qiblah_pro/modules/home/service/namoz_time_service.dart';
import 'package:qiblah_pro/utils/enums.dart';

extension Details on PrayerCalculationMethod {
  NamozTimeCalculation getCalculationDetails() {
    return calculationMethodDetails[index];
  }
}
