import 'package:dartz/dartz.dart';
import 'package:qiblah_pro/core/constants/api/app_urls.dart';
import 'package:qiblah_pro/core/singletons/service_locator.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class NamesService {
  final Dio client = serviceLocator<DioSettings>().dio;
  Future<Either<String, NamesModel>> getNames() async {
    try {
      Response response = await client.get("${AppUrls.names}uzbek");
      print(response.statusCode);
      if (response.statusCode == 200) {
        return right(NamesModel.fromJson(response.data));
      } else {
        return left(response.statusMessage.toString());
      }
    } on DioException catch (e) {
      return left(e.message.toString());
    }
  }
}
