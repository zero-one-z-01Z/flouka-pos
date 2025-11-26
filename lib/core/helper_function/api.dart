import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decode/jwt_decode.dart';
// import 'package:provider/provider.dart';
// import '../../features/auth/presentation/providers/auth_provider.dart';
import '../constants/constants.dart';
import 'convert.dart';
import 'helper_function.dart';
import 'prefs.dart';

class ApiHandel {
  static ApiHandel? _instance;
  late Dio dio;

  ApiHandel._();

  String? token;
  String? lang;
  late CancelToken cancelToken;

  static ApiHandel get getInstance {
    _instance ??= ApiHandel._(); // Instantiate if null
    return _instance!;
  }

  Future<void> init() async {
    lang = sharedPreferences.getString('language_code') ?? "ar";
    token = sharedPreferences.getString('token');
    dio = Dio(
      BaseOptions(
        baseUrl: Constants.domain,
        // will not throw errors
        validateStatus: (status) => true,
        headers: {
          "lang": lang ?? "ar",
          'Content-Type': 'application/json',
          "Authorization": token,
        },
      ),
    );
    // await Future.wait([
    //   for (var i in LanguageProvider.languages) Dio().get('${Constants.baseUri}app_languages/user/${i.languageCode}.json'),
    // ]).then((value) {
    //   Map data = {};
    //   for (int i = 0; i < LanguageProvider.languages.length; i++) {
    //     data[LanguageProvider.languages[i].languageCode] = value[i].data;
    //   }
    //   languages = data;
    // });
  }

  Map languages = {};

  void cancelFunction() async {
    cancelToken.cancel();
  }

  void updateHeader(String token, {String? language}) {
    if (language != null) {
      lang = language;
    }
    dio.options = BaseOptions(
      baseUrl: Constants.domain,
      // baseUrl: Constants.domain,
      headers: {
        "Authorization": token,
        "lang": lang ?? "ar",
        'Content-Type': 'application/json',
      },
    );
  }

  Future<Either<DioException, Response>> get(
    path, [
    Map<String, dynamic>? data,
  ]) async {
    try {
      await reLogin(path);
      cancelToken = CancelToken();
      Response response = await dio.get(
        path,
        queryParameters: data,
        cancelToken: cancelToken,
      );
      if (response.statusCode == 200 && response.data['code'] == 200) {
        return Right(response);
      }
      debugPrint('error1');
      return Left(dioException(response));
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? "");
      return Left(e.response == null ? e : dioException(e.response!));
    } catch (e) {
      debugPrint('error3');
      // print(e.toString());
      return Left(
        DioException(
          requestOptions: RequestOptions(baseUrl: Constants.domain, path: path),
          message: 'Server Error',
        ),
      );
    }
  }

  Future<Either<DioException, Response>> post(
    path,
    Map<String, dynamic> data,
  ) async {
    log(path);
    log(data.toString());
    try {
      await reLogin(path);
      cancelToken = CancelToken();
      Response response = await dio.post(
        path,
        data: FormData.fromMap(data),
        cancelToken: cancelToken,
      );
      if (response.statusCode == 200 &&
          ((!response.data.containsKey('code')) || response.data['code'] == 200)) {
        return Right(response);
      }
      debugPrint('error1');
      return Left(dioException(response));
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? "");
      // print(" ON $e");
      debugPrint('error2');
      return Left(e.response == null ? e : dioException(e.response!));
    } catch (e, line) {
      debugPrint(line.toString());
      debugPrint('error3');
      debugPrint(e.toString());
      // print("dioException ON ${e}");

      return Left(
        DioException(
          requestOptions: RequestOptions(baseUrl: Constants.domain, path: path),
          message: 'Server Error',
        ),
      );
    }
  }

  DioException dioException(Response response) {
    String msg = 'Server Error';
    if (response.data is Map) {
      Map data = response.data;
      if (data['message'] is Map) {
        msg = convertMapToString(data['message']);
      } else if (data['message'] is List) {
        msg = data['message'].join('\n');
      } else {
        msg = data['message'];
      }
    }
    return DioException(
      requestOptions: response.requestOptions,
      message: msg,
      type: msg == 'Server Error'
          ? DioExceptionType.unknown
          : DioExceptionType.badResponse,
      response: response,
      error: 'Server Error',
    );
  }

  Future<Either<DioException, Response>> download(String path) async {
    try {
      debugPrint([path].toString());
      await reLogin(path);
      cancelToken = CancelToken();
      Response response = await dio.download(
        path,
        await getDownloadPath(path.split('/').last),
        cancelToken: cancelToken,
      );
      if (response.statusCode == 200 && response.data['code'] == 200) {
        return Right(response);
      }
      return Left(dioException(response));
    } on DioException catch (e) {
      debugPrint(e.error.toString());
      return Left(e.response == null ? e : dioException(e.response!));
    } catch (e) {
      debugPrint(e.toString());
      return Left(
        DioException(
          requestOptions: RequestOptions(baseUrl: Constants.domain, path: path),
          message: 'Server Error',
        ),
      );
    }
  }

  Future reLogin(String url) async {
    String? token = ApiHandel.getInstance.dio.options.headers['Authorization'];
    if ((url.contains('user')) &&
        !url.contains('social') &&
        token != null &&
        token.isNotEmpty &&
        Jwt.isExpired(token)) {
      // await Provider.of<AuthProvider>(Constants.globalContext(), listen: false,).refreshToken();
    }
  }
}
