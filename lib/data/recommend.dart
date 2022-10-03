import 'package:json_annotation/json_annotation.dart';

part 'recommend.g.dart';

@JsonSerializable()
class Recommend {
  @JsonKey(name: "view_type")
  late String viewType;
  @JsonKey(name: "recommend_data")
  late RecommendData recommendData;

  Recommend(this.viewType, this.recommendData);

  factory Recommend.fromJson(dynamic json) => _$RecommendFromJson(json);

  dynamic toJson() => _$RecommendToJson(this);
}

@JsonSerializable()
class RecommendData {
  @JsonKey(name: "recommend_type")
  late String recommendType;
  @JsonKey(name: "discard_avatar")
  late String discardAvatar;
  @JsonKey(name: "heartbeat_avatar")
  late String heartbeatAvatar;

  //has data
  @JsonKey(name: "is_advanced_recommend")
  late bool? isAdvancedRecommend;
  @JsonKey(name: "recommend_user_data")
  late RecommendUserData? recommendUserData;
  @JsonKey(name: "advanced_recommend_data")
  late AdvancedRecommendData? advancedRecommendData;
  @JsonKey(name: "is_authorize_location")
  late bool? isAuthorizeLocation;

  //no data
  @JsonKey(name: "refresh_recommend_count_time")
  late int? refreshRecommendCountTime;

  RecommendData(
      this.recommendType,
      this.discardAvatar,
      this.heartbeatAvatar,
      this.isAdvancedRecommend,
      this.recommendUserData,
      this.advancedRecommendData,
      this.isAuthorizeLocation,
      this.refreshRecommendCountTime);

  factory RecommendData.fromJson(dynamic json) => _$RecommendDataFromJson(json);

  dynamic toJson() => _$RecommendDataToJson(this);
}

@JsonSerializable()
class RecommendUserData {
  @JsonKey(name: "uid")
  late int uid;
  @JsonKey(name: "type")
  late String type;
  @JsonKey(name: "avatar")
  late String avatar;
  @JsonKey(name: "nickname")
  late String nickname;
  @JsonKey(name: "user_has_tag")
  late bool userHasTag;
  @JsonKey(name: "recommend_user_has_tag")
  late bool? recommendUserHasTag;
  @JsonKey(name: "tag_list")
  late List<String>? tagList;
  @JsonKey(name: "tag_class")
  late String tagClass;
  @JsonKey(name: "recommend_des")
  late String recommendDes;
  @JsonKey(name: "user_location_des")
  late String userLocationDes;
  @JsonKey(name: "has_get_position_role")
  late bool hasGetPositionRole;
  @JsonKey(name: "is_new_user")
  late bool isNewUser;
  @JsonKey(name: "is_show_public_like")
  late bool isShowPublicLike;
  @JsonKey(name: "public_like_desc")
  late String publicLikeDesc;
  @JsonKey(name: "real_name_status")
  late String realNameStatus;
  @JsonKey(name: "real_person_status")
  late String realPersonStatus;

  RecommendUserData(
      this.uid,
      this.type,
      this.avatar,
      this.nickname,
      this.userHasTag,
      this.recommendUserHasTag,
      this.tagList,
      this.tagClass,
      this.recommendDes,
      this.userLocationDes,
      this.hasGetPositionRole,
      this.isNewUser,
      this.isShowPublicLike,
      this.publicLikeDesc,
      this.realNameStatus,
      this.realPersonStatus);

  factory RecommendUserData.fromJson(dynamic json) =>
      _$RecommendUserDataFromJson(json);

  dynamic toJson() => _$RecommendUserDataToJson(this);
}

@JsonSerializable()
class AdvancedRecommendData {
  @JsonKey(name: "can_op_user")
  late bool canOpUser;
  @JsonKey(name: "sub_des")
  late String subDes;
  @JsonKey(name: "advanced_tag_list")
  late List<String> advancedTagList;

  AdvancedRecommendData(this.canOpUser, this.subDes, this.advancedTagList);

  factory AdvancedRecommendData.fromJson(dynamic json) =>
      _$AdvancedRecommendDataFromJson(json);

  dynamic toJson() => _$AdvancedRecommendDataToJson(this);
}
