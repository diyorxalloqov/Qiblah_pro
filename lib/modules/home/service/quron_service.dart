import 'package:dartz/dartz.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/models/quron_model.dart';

class QuronService {
  final Dio client = serviceLocator<DioSettings>().dio;
  final QuronDBService _quronDBService = QuronDBService();
  String lang =
      StorageRepository.getString(Keys.lang) == 'ru' ? "russian" : 'uzbek';
  Future<Either<String, List<QuronModel>>> getQuranList(
      int limit, int page) async {
    try {
      Response response = await client.get(
        "${AppUrls.quronSurahList}limit=$limit&page=$page&lang=$lang",
      );
      debugPrint(response.realUri.toString());
      debugPrint(response.data.toString());
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        List<QuronModel> dataList = (response.data['data'] as List)
            .map((e) => QuronModel.fromJson(e))
            .toList();
        for (var myData in dataList) {
          await _quronDBService.insertQuron(myData);
        }
        debugPrint(response.statusCode.toString());
        return right(dataList);
      } else {
        return left(response.statusMessage.toString());
      }
    } on DioException catch (e) {
      debugPrint('exeption');
      debugPrint(e.message);
      return left(NetworkExeptionResponse(e).messageForUser);
    }
  }

  Future<Either<String, List<OyatModel>>> getOyatbyIndex(int index) async {
    try {
      Response response = await client
          .get("${AppUrls.oyatById}/$index/", queryParameters: {
        'lang':
            StorageRepository.getString(Keys.lang) == 'ru' ? "russian" : 'uzbek'
      });
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        List<OyatModel> dataList = (response.data['data'] as List)
            .map((e) => OyatModel.fromJson(e))
            .toList();

        for (var element in dataList) {
          await QuronDBService().insertOyatList(element);
        }
        debugPrint(dataList.toString());
        return right(dataList);
      } else {
        debugPrint(response.statusMessage);
        debugPrint(response.statusCode.toString());
        return left(response.statusMessage.toString());
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      debugPrint('exeption');
      return left(NetworkExeptionResponse(e).messageForUser);
    }
  }

  Future<Either<String, List<OyatModel>>> getOyatbyjuzNumber(int index) async {
    try {
      Response response = await client
          .get("${AppUrls.oyatByJuz}/$index/", queryParameters: {
        'lang':
            StorageRepository.getString(Keys.lang) == 'ru' ? "russian" : 'uzbek'
      });
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        List<OyatModel> dataList = (response.data['data'] as List)
            .map((e) => OyatModel.fromJson(e))
            .toList();

        for (var element in dataList) {
          await QuronDBService().insertOyatList(element);
        }
        debugPrint(dataList.toString());
        return right(dataList);
      } else {
        debugPrint(response.statusMessage);
        debugPrint(response.statusCode.toString());
        return left(response.statusMessage.toString());
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      debugPrint('exeption');
      return left(NetworkExeptionResponse(e).messageForUser);
    }
  }
}
