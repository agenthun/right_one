import 'package:right_one/api/api_service.dart';
import 'package:right_one/data/daily_recommend.dart';
import 'package:right_one/data/heart_beat_me_list.dart';
import 'package:right_one/data/like_result.dart';
import 'package:right_one/data/recommend.dart';
import 'package:right_one/data/result.dart';
import 'package:right_one/data/user_profile.dart';

class CpRepository {
  static final CpRepository _instance = CpRepository._init();

  factory CpRepository() => _instance;

  CpRepository._init();

  Future<Map<String, dynamic>> getUserProfile(int uid) async {
    Result? result;
    try {
      result = await ApiService().getUserProfile(uid);
    } catch (e) {
      return {"error": e};
    }
    if (result == null) return {"error": Exception("result is null")};
    var data = UserProfile.fromJson(result.data);
    data.uid = uid;
    return {"data": data};
  }

  Future<Map<String, dynamic>> getRecommend() async {
    Result? result;
    try {
      result = await ApiService().getRecommend();
    } catch (e) {
      return {"error": e};
    }
    if (result == null) return {"error": Exception("result is null")};
    var recommend = Recommend.fromJson(result.data);
    var uid = recommend.recommendData.recommendUserData?.uid;
    if (uid == null) return {"error": Exception("uid is null")};
    return await getUserProfile(uid);
  }

  Future<Map<String, dynamic>> getDailyRecommend() async {
    Result? result;
    try {
      result = await ApiService().getDailyRecommend();
    } catch (e) {
      return {"error": e};
    }
    if (result == null) return {"error": Exception("result is null")};
    var recommend = DailyRecommend.fromJson(result.data);
    var uid = recommend.featuredRecommendUser.uid;
    if (uid == null) return {"error": Exception("uid is null")};
    return await getUserProfile(uid);
  }

  Future<Map<String, dynamic>> getHeartBeatMeList() async {
    Result? result;
    try {
      result = await ApiService().getHeartBeatMeList();
    } catch (e) {
      return {"error": e};
    }
    if (result == null) return {"error": Exception("result is null")};
    var data = HeartBeatMeList.fromJson(result.data);
    return {"data": data};
  }

  Future<Map<String, dynamic>> like(int uid) async {
    Result? result;
    try {
      result = await ApiService().like(uid);
    } catch (e) {
      return {"error": e};
    }
    if (result == null) return {"error": Exception("result is null")};
    var data = LikeResult.fromJson(result.data);
    return {"data": data};
  }

  Future<Map<String, dynamic>> unlike(int uid) async {
    Result? result;
    try {
      result = await ApiService().unlike(uid);
    } catch (e) {
      return {"error": e};
    }
    if (result == null) return {"error": Exception("result is null")};
    return {"data": result.data};
  }
}
