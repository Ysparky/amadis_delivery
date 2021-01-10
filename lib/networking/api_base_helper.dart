import 'package:dio/dio.dart';

import 'package:amadis_delivery/core/utils/constants.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/networking/api_response.dart';

class ApiBaseHelper {
  final String _baseUrl = BASE_URL;
  final _dio = Dio();

  Future<ApiResponse> get(
    String url, {
    Map<String, dynamic> params,
  }) async {
    try {
      final response = await _dio.get(
        _baseUrl + url,
        queryParameters: params,
      );
      return ApiResponse.completed(response.data['data']);
    } on DioError catch (e) {
      return _errorResponse(e);
    }
  }

  Future<ApiResponse> post(
    String url, {
    Map<String, dynamic> body,
    Map<String, dynamic> params,
  }) async {
    try {
      final response = await _dio.post(
        _baseUrl + url,
        queryParameters: params,
        data: body,
      );
      return ApiResponse.completed(response.data['data']);
    } on DioError catch (e) {
      return _errorResponse(e);
    }
  }

  Future<ApiResponse> put(
    String url, {
    Map<String, dynamic> body,
    Map<String, dynamic> params,
  }) async {
    try {
      final response = await _dio.put(
        _baseUrl + url,
        queryParameters: params,
        data: body,
      );
      return ApiResponse.completed(response.data['data']);
    } on DioError catch (e) {
      return _errorResponse(e);
    }
  }

  ApiResponse _errorResponse(DioError e) {
    var message = '';
    var statusCode = 0;
    if (DioErrorType.CONNECT_TIMEOUT == e.type ||
        DioErrorType.RECEIVE_TIMEOUT == e.type) {
      print('Handle no internet connection');
      message =
          'El servidor no es accesible. Por favor, verifique su conexión a Internet e inténtelo de nuevo.';
    } else if (DioErrorType.RESPONSE == e.type) {
      print('Handle response error');
      statusCode = e.response.statusCode;
      if (e.response.statusCode != 500) {
        final errorResponse = ErrorResponse.fromJson(e.response.data);
        message = errorResponse.data.error ?? e.response.statusMessage;
      } else {
        message = e.response.statusMessage;
      }
    } else if (DioErrorType.DEFAULT == e.type) {
      if (e.message.contains('SocketException')) {
        print('No hay conexión a internet');
        message = 'No hay conexión a internet';
      } else {
        print('Ocurrió un problema contectando con el servidor');
        message =
            'Problema al conectarse al servidor. Por favor, inténtelo de nuevo.';
      }
    }
    return ApiResponse.error(message, statusCode);
  }
}
