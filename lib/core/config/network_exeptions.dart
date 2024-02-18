import 'package:dio/dio.dart';

abstract class NetworkResponseConfig {
  NetworkResponseConfig();
}

class NetworkSuccesResponse<Model> extends NetworkResponseConfig {
  Model model;
  NetworkSuccesResponse(this.model);
}

class NetworkErrorResponse extends NetworkResponseConfig {
  String error = "";
  NetworkErrorResponse(this.error);
}

class NetworkExeptionResponse extends NetworkResponseConfig {
  DioException exeption;
  String messageForUser = '';
  NetworkExeptionResponse(this.exeption) {
    print(exeption.type);
    if (exeption.type == DioExceptionType.sendTimeout ||
        exeption.type == DioExceptionType.unknown) {
      messageForUser = 'Iltimos Internetingizni tekshiring';
    } else if (exeption.type == DioExceptionType.connectionTimeout ||
        exeption.type == DioExceptionType.receiveTimeout) {
      messageForUser = 'Serverga bog\'lanib bo\'lmadi';
    } else if (exeption.type == DioExceptionType.connectionError ||
        exeption.type == DioExceptionType.cancel) {
      messageForUser = 'Internet mavjud emas';
    } else {
      messageForUser = exeption.message.toString();
    }
  }
}
