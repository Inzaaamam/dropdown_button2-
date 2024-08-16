import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioHelper {
  late Dio dio;
  DioHelper({required String baseUrl})
      : dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        );
  Future<Map<String, dynamic>> postLogin(Map<String, dynamic> data) async {
    try {
      Response response = await dio.post('login', data: data);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to login: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }
}

class DioClient {
  static const connectTimeout = 24000;
  static const receiverTimeout = 24000;
  static const senderTimeout = 24000;
  static const baseUrl = 'http://192.168.10.120:3001/api/resource/';
  static Dio? dio;
  static Future init() async {
    dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        receiveTimeout: const Duration(
          seconds: connectTimeout,
        ),
        connectTimeout: const Duration(seconds: connectTimeout)));
  }

  Future getData() async {
    try {
      // ignore: unused_local_variable
      final response = await dio!.post('$baseUrl/login', data: {});
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('invalid request');
      }
    } catch (e) {}
  }
}

// import 'dart:io';

// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio/dio.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// import 'package:path_provider/path_provider.dart';

// class DioClientConfig {
//   static const connectTimeout = 24000;
//   static const receiveTimeout = 120000;
//   static const sendTimeout = 60000;
//   static const baseURL = 'http://192.168.10.120:3001/api/resource/';

//   static Dio? dio; // With default `Options`.
//   static String? cookies;

//   static Future init() async {
//     var cookieJar = await getCookiePath();

//     dio = Dio(BaseOptions(
//       baseUrl: baseURL,
//       connectTimeout: const Duration(seconds: connectTimeout),
//       receiveTimeout: const Duration(seconds: receiveTimeout),
//     ));
//     dio?.interceptors.add(CookieManager(cookieJar));
//   }

//   static Future initCookies() async {
//     cookies = await getCookies();
//   }

//   static Future<PersistCookieJar> getCookiePath() async {
//     Directory appDocDir = await getApplicationSupportDirectory();
//     String appDocPath = appDocDir.path;
//     return PersistCookieJar(ignoreExpires: true, storage: FileStorage(appDocPath));
//   }

//   static Future<String?> getCookies() async {
//     var cookieJar = await getCookiePath();
//     var cookies = await cookieJar.loadForRequest(Uri.parse(baseURL));
//     var cookie = CookieManager.getCookies(cookies)
// ;
//     return cookie;
//   }
// }