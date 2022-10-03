import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
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
        "1560976019693678_5247899_1690741655_4519047911946d4e0d1c52fecf896cbf";
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
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      compact: false,
    ));
  }

  Future<Result?> getUserProfile(int uid, {String from = "recommend"}) {
    return _request(() {
      return _dio
          .get("/api/apps/wcp/user/get-user-profile-start", queryParameters: {
        "fuid": uid,
        "from": from,
      });
    });
  }

  Future<Result?> getRecommend() {
    return _request(() {
      return _dio.get("/api/apps/wcp/match/get-recommend-data");
    });
  }

  Future<Result?> getDailyRecommend() {
    return _request(() {
      return _dio.get("/api/apps/wcp/meet/get-featured-recommend-info");
    });
  }

  Future<Result?> getHeartBeatMeList({int start = 0, int num = 10}) {
    return _request(() {
      return _dio
          .get("/api/apps/wcp/match/get-heartbeat-me-list", queryParameters: {
        "start": start,
        "num": num,
      });
    });
  }

  Future<Result?> _request(Future<Response?> Function() api) async {
    Response? resp;
    try {
      resp = await api();
    } catch (e) {
      return null;
    }
    return resp?.data;
  }
}
