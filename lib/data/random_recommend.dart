import 'package:json_annotation/json_annotation.dart';

part 'random_recommend.g.dart';

@JsonSerializable()
class RandomRecommend {
  @JsonKey(name: "new_login_model")
  late bool newLoginModel;
  @JsonKey(name: "user_info")
  late RandomRecommendUserInfo userInfo;

  RandomRecommend(this.newLoginModel, this.userInfo);

  factory RandomRecommend.fromJson(dynamic json) =>
      _$RandomRecommendFromJson(json);

  dynamic toJson() => _$RandomRecommendToJson(this);
}

@JsonSerializable()
class RandomRecommendUserInfo {
  @JsonKey(name: "uid")
  late int uid;
  @JsonKey(name: "avatar")
  late String avatar;

  RandomRecommendUserInfo(this.uid, this.avatar);

  factory RandomRecommendUserInfo.fromJson(dynamic json) =>
      _$RandomRecommendUserInfoFromJson(json);

  dynamic toJson() => _$RandomRecommendUserInfoToJson(this);
}
