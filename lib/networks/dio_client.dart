import 'package:apps_architecture/di/injections_container.dart';
import 'package:dio/dio.dart';

class DioClient {
  late Dio dio;

  DioClient() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(seconds: 5),
    ));

    // Add logging interceptor
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Called before the request is sent
        logger.i('Request: ${options.method} ${options.uri}');
        logger.i('Headers: ${options.headers}');
        logger.i('Request body: ${options.data}');
        return handler.next(options); // Continue
      },
      onResponse: (response, handler) {
        // Called when the response is received
        logger.i('Response: ${response.statusCode}');
        logger.i('Response body: ${response.data}');
        return handler.next(response); // Continue
      },
      onError: (DioException e, handler) {
        // Called when an error occurs
        logger.e('Error: ${e.message}');
        logger.e('Error response: ${e.response?.statusCode}');
        logger.e('Error data: ${e.response?.data}');
        return handler.next(e); // Continue
      },
    ));
  }

  Future<Response> get(String path) async {
    try {
      final response = await dio.get(path);
      return response;
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
}
