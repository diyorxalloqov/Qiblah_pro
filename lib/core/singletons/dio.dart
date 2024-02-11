import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class DioSettings {
  final BaseOptions _dioBaseOptions = BaseOptions(
    // baseUrl: AppUrls.baseUrl,
    connectTimeout: const Duration(seconds: 35),
    receiveTimeout: const Duration(seconds: 35),
    contentType: 'application/json',
    validateStatus: (status) =>
        status != null && status >= 100 && status <= 599,
    // headers: {
    //   'Content-Type': 'application/json',
    //   'Authorization': "Bearer ${await accessToken}"
    // },
  );

  BaseOptions get dioBaseOptions => _dioBaseOptions;

  Dio get dio {
    var dio1 = Dio(_dioBaseOptions)
      ..interceptors.add(InterceptorsWrapper(
        // onError: (DioException e, ErrorInterceptorHandler handler) async {
        //   print('Interceptor OnError');
        //   if (e.response?.statusCode == 401) {
        //     print('Refresh Token');
        //     var responseRefresh =
        //         await Dio().post("AppUrls.tokenRefresh", data: {
        //       "token":
        //           await const FlutterSecureStorage().read(key: "Keys.refresh"),
        //       "type": "refresh",
        //     });
        //     if (responseRefresh.statusCode! >= 200 &&
        //         responseRefresh.statusCode! < 300) {
        //       const FlutterSecureStorage().write(
        //           key: "Keys.access", value: responseRefresh.data['access']);
        //       const FlutterSecureStorage().write(
        //           key: "Keys.refresh", value: responseRefresh.data['refresh']);
        //       handler.next(e);
        //     } else {
        //       // Handle refresh token failure
        //       // You might want to throw an error or handle it accordingly
        //     }
        //   } else {
        //     handler.next(e);
        //   }
        // },
        // onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        //   print('Interceptor OnRequest');

        //   options.headers.addAll({'Accept-Language': "uz"});
        //   handler.next(options);
        // },
        // onResponse:
        //     (Response response, ResponseInterceptorHandler handler) async {
        //   print('Interceptor OnResponse');
        //   // Modify response here if needed
        //   handler.next(response);
        // },
      ));
    return dio1;
  }
}
