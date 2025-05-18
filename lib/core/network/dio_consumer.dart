import 'package:dio/dio.dart';
import 'package:shaty/core/network/api_consumer.dart';
import 'package:shaty/core/network/end_points.dart';
import '../errors/exceptions.dart';
import '../errors/server_exception.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer(this.dio) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true));
    dio.options.headers = {
      'Accept': 'application/json',
    };
  }

  @override
  Future delete(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    final response = await dio.delete(path,
        data: data, options: options, queryParameters: queryParameters);
    return response.data;
  }

  @override
  Future get(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    // TODO: implement
    final response = await dio.get(path,
        data: data, options: options, queryParameters: queryParameters);
    return response.data;
  }

  @override
  Future post(String path, {Object? data, Options? options}) async {
    try {
      final response = await dio.post(path, data: data, options: options);
      return response.data;
    } on DioException catch (e) {
      throw ServerException(ErrorHandler.handle(e.message));
    }
  }

  @override
  Future put(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        options: options,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerException(ErrorHandler.handle(e.message));
    }
  }
}
