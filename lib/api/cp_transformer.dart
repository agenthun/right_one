import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:right_one/data/result.dart';

class CpTransformer extends DefaultTransformer {
  @override
  Future transformResponse(
      RequestOptions options, ResponseBody response) async {
    var resp = await super.transformResponse(options, response);
    log("CpTransformer, $resp");
    if (resp is Map<String, dynamic>) {
      var result = Result.fromJson(resp);
      if (result.code == 0) {
        return result;
      } else {
        throw DioError(
          requestOptions: options,
          error: result,
        );
      }
    }
    return resp;
  }
}
