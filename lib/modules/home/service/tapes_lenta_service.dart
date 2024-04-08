import 'package:dartz/dartz.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class TapesLentaService {
  final Dio client = serviceLocator<DioSettings>().dio;
  String lang =
      StorageRepository.getString(Keys.lang) == 'ru' ? "russian" : 'uzbek';
  Future<Either<String, TapesModel>> getTapesData() async {
    try {
      Response response = await client
          .get(AppUrls.getTapesLenta, queryParameters: {"lang": lang});
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return right(TapesModel.fromJson(response.data));
      } else {
        return left(
            NetworkErrorResponse(response.statusMessage.toString()).error);
      }
    } on DioException catch (e) {
      return left(NetworkExeptionResponse(e).messageForUser);
    }
  }
}
