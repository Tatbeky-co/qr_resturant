import 'package:dio/dio.dart';

class DioApi {
  static Dio? _dio;
  static init() {
    _dio = Dio(BaseOptions(
        baseUrl: "https://instinctive-fish-utahceratops.glitch.me/",
        receiveDataWhenStatusError: true,
        followRedirects: true,
        validateStatus: (status) { return status! < 500;},
        headers: {'Content-Type': 'application/json','Accept':'application/json'}));
  }

  static Future<Response?> getData({url, query}) async {
    _dio?.options.headers = { 'Accept':'application/json',"Access-Control-Allow-Origin": "*"};
    return await _dio?.get(url,queryParameters: query ??{});
  }

  static Future<Response?> postData(
      {url,Map<String,dynamic>? query, data,onsend}) async {
    _dio?.options.headers = {'Accept':'application/json',"Access-Control-Allow-Origin": "*"};
    return _dio?.post(url, queryParameters: query, data: data,onSendProgress: onsend);
  }

  static Future<Response?> putData(
      {url, query, data,}) async {

    return _dio?.put(url, queryParameters: query, data: data);
  }

  static Future<Response?> deleteData(
      {url, query, data,}) async {

    return _dio?.delete(url, queryParameters: query, data: data);
  }
}
