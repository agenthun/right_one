import 'package:json_annotation/json_annotation.dart';

part 'daily_recommend.g.dart';

@JsonSerializable()
class DailyRecommend {
  @JsonKey(name: "featured_recommend_user")
  late FeaturedRecommendUser featuredRecommendUser;

  DailyRecommend(this.featuredRecommendUser);

  factory DailyRecommend.fromJson(dynamic json) =>
      _$DailyRecommendFromJson(json);

  dynamic toJson() => _$DailyRecommendToJson(this);
}

@JsonSerializable()
class FeaturedRecommendUser {
  @JsonKey(name: "uid")
  late int? uid;
  @JsonKey(name: "avatar")
  late String? avatar;
  @JsonKey(name: "nickname")
  late String? nickname;
  @JsonKey(name: "is_new_user")
  late bool? isNewUser;
  @JsonKey(name: "user_des")
  late String? userDes;

  @JsonKey(name: "is_waiting_refresh")
  late bool isWaitingRefresh;

  FeaturedRecommendUser(this.uid, this.avatar, this.nickname, this.isNewUser,
      this.userDes, this.isWaitingRefresh);

  factory FeaturedRecommendUser.fromJson(dynamic json) =>
      _$FeaturedRecommendUserFromJson(json);

  dynamic toJson() => _$FeaturedRecommendUserToJson(this);
}
