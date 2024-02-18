import 'package:dartz/dartz.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/models/zikr_model.dart';

class ZikrService {
  final Dio client = serviceLocator<DioSettings>().dio;
  final ZikrDBSevice _zikrDbService = ZikrDBSevice();
  Future<Either<String, List<ZikrModel>>> getCategories() async {
    try {
      print('response is trying to');
      Response response = await client.get(AppUrls.zikrNames, queryParameters: {
        'lang':
            StorageRepository.getString(Keys.lang) == 'ru' ? "russian" : 'uzbek'
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<ZikrModel> dataList = (response.data['data'] as List)
            .map((e) => ZikrModel.fromJson(e))
            .toList();
        for (var myData in dataList) {
          await _zikrDbService.insertZikrs(myData);
        }
        return right(dataList);
      } else {
        return left(
            NetworkErrorResponse(response.statusMessage.toString()).error);
      }
    } on DioException catch (e) {
      print('exeption $e');
      return left(NetworkExeptionResponse(e).messageForUser);
    }
  }
}
