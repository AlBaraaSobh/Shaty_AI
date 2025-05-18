import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<dynamic> post(
      String path,
      {Object? data, Options? options}
      );

  Future<dynamic> get(
      String path,
      {Object? data, Map<String, dynamic>? queryParameters, Options? options}
      );

  Future<dynamic> put(
      String path,
      {Object? data, Map<String, dynamic>? queryParameters, Options? options}
      );


  Future<dynamic> delete(
      String path,
      {Object? data, Map<String, dynamic>? queryParameters, Options? options}
      );
}
