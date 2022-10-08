import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:right_one/api/api_const.dart';
import 'package:right_one/api/cp_transformer.dart';
import 'package:right_one/data/result.dart';

class ApiService {
  static final ApiService _instance = ApiService._init();

  factory ApiService() => _instance;

  late Dio _dio;

  ApiService._init() {
    var appId = "1560976019693678";
    var token =
        "1560976019693678_5247899_1691120145_40adc3be4e8474939907579fbcd68f5e";
    var options = BaseOptions(
      baseUrl: yizhoucp_host,
      headers: {
        "app-id": appId,
        "token": token,
        "Access-Control-Allow-Origin": "*"
      },
    );
    _dio = Dio(options);
    _initInterceptors();
    _dio.transformer = CpTransformer();
  }

  void _initInterceptors() {
    var cookieJar = DefaultCookieJar();
    _dio.interceptors.add(CookieManager(cookieJar));
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: _print,
    ));
  }

  void _print(Object? object) {
    log("$object");
  }

  Future<Result?> getUserProfile(int uid, {String from = "recommend"}) async {
    var resp = await _dio
        .get("/api/apps/wcp/user/get-user-profile-start", queryParameters: {
      "fuid": uid,
      "from": from,
    });
    return resp.data;
  }

  Future<Result?> getRecommend() async {
    var resp = await _dio.get("/api/apps/wcp/match/get-recommend-data");
    return resp.data;
  }

  Future<Result?> getDailyRecommend() async {
    var resp = await _dio.get("/api/apps/wcp/meet/get-featured-recommend-info");
    return resp.data;
  }

  Future<Result?> getRandomRecommend() async {
    var resp = await _dio
        .get("/api/apps/wcp/match/get-random-recommend-info", queryParameters: {
      "sex": "boy",
    });
    return resp.data;
  }

  Future<Result?> getHeartBeatMeList({int start = 0, int num = 10}) async {
    var resp = await _dio
        .get("/api/apps/wcp/match/get-heartbeat-me-list", queryParameters: {
      "start": start,
      "num": num,
    });
    return resp.data;
  }

  Future<Result?> getCpCandidateList() async {
    var resp = await _dio.get("/api/apps/wcp/match/get-cp-candidate-data");
    return resp.data;
  }

  Future<Result?> like(int uid, {String from = "recommend"}) async {
    var formData =
        FormData.fromMap({"form_id": "undefined", "fuid": uid, "from": from});
    var resp =
        await _dio.post("/api/apps/wcp/like/heartbeat-user", data: formData);
    return resp.data;
  }

  Future<Result?> unlike(int uid, {String from = "recommend"}) async {
    var formData =
        FormData.fromMap({"form_id": "undefined", "fuid": uid, "from": from});
    var resp =
        await _dio.post("/api/apps/wcp/like/discard-user", data: formData);
    return resp.data;
  }
}
