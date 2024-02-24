import 'package:dartz/dartz.dart';
import 'package:qiblah_pro/core/db/quron_db_service.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/models/oyat_model.dart';
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
      print(response.realUri);
      print(response.data);
      if (response.statusCode == 200) {
        List<QuronModel> dataList = (response.data['data'] as List)
            .map((e) => QuronModel.fromJson(e))
            .toList();
        for (var myData in dataList) {
          await _quronDBService.insertQuron(myData);
        }
        print(response.statusCode);
        return right(dataList);
      } else {
        return left(response.statusMessage.toString());
      }
    } on DioException catch (e) {
      print('exeption');
      print(e.message);
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
      if (response.statusCode == 200) {
        List<OyatModel> dataList = (response.data['data'] as List)
            .map((e) => OyatModel.fromJson(e))
            .toList();

        for (var element in dataList) {
          await QuronDBService().insertOyatList(element);
        }

        print(dataList);
        return right(dataList);
      } else {
        print(response.statusMessage);
        print(response.statusCode);
        return left(response.statusMessage.toString());
      }
    } on DioException catch (e) {
      print(e.message);
      print('exeption');
      return left(NetworkExeptionResponse(e).messageForUser);
    }
  }
}
