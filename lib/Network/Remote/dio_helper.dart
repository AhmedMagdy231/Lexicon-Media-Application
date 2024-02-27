import 'package:dio/dio.dart';
import '../endPoind.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: baseUrl,
        headers: {},
      ),
    );
  }

  static Future<Response> postData(
      {
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String? token,
      required String url
      }) async {
    return await dio.post(
      url,
      queryParameters: query,
      data: FormData.fromMap(data),
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        }
      ),
    );
  }


  static Future<Response> getData(
      {Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String? token,
      required String url}) async {
    return await dio.get(
      url,
      queryParameters: query,
      //data: FormData.fromMap(data),
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }


  static Future<Response> postDataImage({

    Map<String, dynamic>? query,
    required FormData data,
    String? token,
    required String url}) async {
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'multipart/form-data',
        },

      ),
    );
  }

}
