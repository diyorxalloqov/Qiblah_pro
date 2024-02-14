import 'package:dartz/dartz.dart';
import 'package:qiblah_pro/core/constants/api/app_urls.dart';
import 'package:qiblah_pro/core/singletons/service_locator.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/models/quron_model.dart';

class QuronService {
  final Dio client = serviceLocator<DioSettings>().dio;
  Future<Either<String, QuronModel>> getQuranList() async {
    try {
      Response response = await client.get("${AppUrls.quronSurahList}uzbek");
      if (response.statusCode == 200) {
        return right(QuronModel.fromJson(response.data));
      } else {
        return left(response.statusMessage.toString());
      }
    } on DioException catch (e) {
      return left(e.message.toString());
    }
  }
}
