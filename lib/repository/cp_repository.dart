import 'package:right_one/api/api_service.dart';
import 'package:right_one/data/cp_candidate_list.dart';
import 'package:right_one/data/daily_recommend.dart';
import 'package:right_one/data/heart_beat_me_list.dart';
import 'package:right_one/data/like_result.dart';
import 'package:right_one/data/random_recommend.dart';
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
    var isNoRecommend = recommend.recommendData.isNoRecommend;
    if (isNoRecommend) return {"error": Exception("is no recommend data")};
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
    if (uid is String) {
      uid = int.tryParse(uid);
    }
    if (uid == null) return {"error": Exception("uid is null")};
    return await getUserProfile(uid);
  }

  Future<Map<String, dynamic>> getRandomRecommend() async {
    Result? result;
    try {
      result = await ApiService().getRandomRecommend();
    } catch (e) {
      return {"error": e};
    }
    if (result == null) return {"error": Exception("result is null")};
    var recommend = RandomRecommend.fromJson(result.data);
    var uid = recommend.userInfo.uid;
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
    var list = data.cpCandidateWrapperList;
    return {"data": list};
  }

  Future<Map<String, dynamic>> getCpCandidateList() async {
    Result? result;
    try {
      result = await ApiService().getCpCandidateList();
    } catch (e) {
      return {"error": e};
    }
    if (result == null) return {"error": Exception("result is null")};
    var data = CpCandidateList.fromJson(result.data);
    var list = data.list?.map((e) => e.toCpCandidateWrapper()).toList() ??
        List.empty();
    return {"data": list};
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
