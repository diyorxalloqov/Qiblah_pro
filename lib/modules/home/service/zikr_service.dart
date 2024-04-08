import 'package:dartz/dartz.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/models/zikr_model.dart';

class ZikrService {
  final Dio client = serviceLocator<DioSettings>().dio;
  final ZikrDBSevice _zikrDBSevice = ZikrDBSevice();
  Future<Either<String, List<ZikrCategoryModel>>> getCategories() async {
    try {
      print('response is trying to');
      Response response = await client.get(AppUrls.zikrNames, queryParameters: {
        'lang':
            StorageRepository.getString(Keys.lang) == 'ru' ? "russian" : 'uzbek'
      });
      print(response.statusCode);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        List<ZikrCategoryModel> dataList = (response.data['data'] as List)
            .map((e) => ZikrCategoryModel.fromJson(e))
            .toList();
        List<ZikrCategoryModel> reverseDataList = dataList.reversed.toList();
        for (var myData in reverseDataList) {
          await _zikrDBSevice.insertCategory(myData);
        }
        return right(reverseDataList);
      } else {
        return left(
            NetworkErrorResponse(response.statusMessage.toString()).error);
      }
    } on DioException catch (e) {
      print('exeption $e');
      return left(NetworkExeptionResponse(e).messageForUser);
    }
  }

  Future<Either<String, List<ZikrModel>>> getZikrs(
      int categoryId, int limit, int page) async {
    try {
      print('response is trying to Zikr');
      Response response = await client.get(AppUrls.zikrs, queryParameters: {
        "limit": limit,
        "page": page,
        "category_id": categoryId
      });
      print(response.statusCode);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        List<ZikrModel> dataList = (response.data['data'] as List)
            .map((e) => ZikrModel.fromJson(e))
            .toList();
        List<ZikrModel> reverseDataList = dataList.reversed.toList();
        for (var myData in reverseDataList) {
          await _zikrDBSevice.insertZikrs(myData);
        }
        return right(reverseDataList);
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
