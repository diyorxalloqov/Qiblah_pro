import 'package:dartz/dartz.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class NamesService {
  final Dio client = serviceLocator<DioSettings>().dio;
  final NamesDbService _namesDbService = NamesDbService();
  Future<Either<String, List<NamesData>>> getNames() async {
    try {
      debugPrint('response is trying to');
      Response response = await client.get(AppUrls.names, queryParameters: {
        'lang':
            StorageRepository.getString(Keys.lang) == 'ru' ? "russian" : 'uzbek'
      });
      debugPrint(response.statusCode.toString());
      debugPrint(response.data.toString());
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        List<NamesData> dataList = (response.data['data'] as List)
            .map((e) => NamesData.fromJson(e))
            .toList();
        debugPrint(response.realUri.toString());
        for (var myData in dataList) {
          await _namesDbService.insertNames(myData);
        }
        return right(dataList);
      } else {
        return left(
            NetworkErrorResponse(response.statusMessage.toString()).error);
      }
    } on DioException catch (e) {
      debugPrint('exeption $e');
      return left(NetworkExeptionResponse(e).messageForUser);
    }
  }
}
