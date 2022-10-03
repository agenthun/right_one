import 'package:right_one/api/api_service.dart';
import 'package:right_one/data/daily_recommend.dart';
import 'package:right_one/data/heart_beat_me_list.dart';
import 'package:right_one/data/recommend.dart';
import 'package:right_one/data/user_profile.dart';

class CpRepository {
  static final CpRepository _instance = CpRepository._init();

  factory CpRepository() => _instance;

  CpRepository._init();

  Future<UserProfile?> getUserProfile(int uid) async {
    var result = await ApiService().getUserProfile(uid);
    if (result == null) return null;
    return UserProfile.fromJson(result.data);
  }

  Future<UserProfile?> getRecommend() async {
    var result = await ApiService().getRecommend();
    if (result == null) return null;
    var recommend = Recommend.fromJson(result.data);
    var uid = recommend.recommendData.recommendUserData?.uid;
    if (uid == null) return null;
    return await getUserProfile(uid);
  }

  Future<UserProfile?> getDailyRecommend() async {
    var result = await ApiService().getDailyRecommend();
    if (result == null) return null;
    var recommend = DailyRecommend.fromJson(result.data);
    var uid = recommend.featuredRecommendUser.uid;
    if (uid == null) return null;
    return await getUserProfile(uid);
  }

  Future<HeartBeatMeList?> getHeartBeatMeList() async {
    var result = await ApiService().getHeartBeatMeList();
    if (result == null) return null;
    return HeartBeatMeList.fromJson(result.data);
  }
}
