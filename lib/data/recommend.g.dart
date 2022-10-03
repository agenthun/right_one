// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recommend _$RecommendFromJson(Map<String, dynamic> json) => Recommend(
      json['view_type'] as String,
      RecommendData.fromJson(json['recommend_data']),
    );

Map<String, dynamic> _$RecommendToJson(Recommend instance) => <String, dynamic>{
      'view_type': instance.viewType,
      'recommend_data': instance.recommendData,
    };

RecommendData _$RecommendDataFromJson(Map<String, dynamic> json) =>
    RecommendData(
      json['recommend_type'] as String,
      json['discard_avatar'] as String,
      json['heartbeat_avatar'] as String,
      json['is_advanced_recommend'] as bool?,
      json['recommend_user_data'] == null
          ? null
          : RecommendUserData.fromJson(json['recommend_user_data']),
      json['advanced_recommend_data'] == null
          ? null
          : AdvancedRecommendData.fromJson(json['advanced_recommend_data']),
      json['is_authorize_location'] as bool?,
      json['refresh_recommend_count_time'] as int?,
    );

Map<String, dynamic> _$RecommendDataToJson(RecommendData instance) =>
    <String, dynamic>{
      'recommend_type': instance.recommendType,
      'discard_avatar': instance.discardAvatar,
      'heartbeat_avatar': instance.heartbeatAvatar,
      'is_advanced_recommend': instance.isAdvancedRecommend,
      'recommend_user_data': instance.recommendUserData,
      'advanced_recommend_data': instance.advancedRecommendData,
      'is_authorize_location': instance.isAuthorizeLocation,
      'refresh_recommend_count_time': instance.refreshRecommendCountTime,
    };

RecommendUserData _$RecommendUserDataFromJson(Map<String, dynamic> json) =>
    RecommendUserData(
      json['uid'] as int,
      json['type'] as String,
      json['avatar'] as String,
      json['nickname'] as String,
      json['user_has_tag'] as bool,
      json['recommend_user_has_tag'] as bool?,
      (json['tag_list'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['tag_class'] as String,
      json['recommend_des'] as String,
      json['user_location_des'] as String,
      json['has_get_position_role'] as bool,
      json['is_new_user'] as bool,
      json['is_show_public_like'] as bool,
      json['public_like_desc'] as String,
      json['real_name_status'] as String,
      json['real_person_status'] as String,
    );

Map<String, dynamic> _$RecommendUserDataToJson(RecommendUserData instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'type': instance.type,
      'avatar': instance.avatar,
      'nickname': instance.nickname,
      'user_has_tag': instance.userHasTag,
      'recommend_user_has_tag': instance.recommendUserHasTag,
      'tag_list': instance.tagList,
      'tag_class': instance.tagClass,
      'recommend_des': instance.recommendDes,
      'user_location_des': instance.userLocationDes,
      'has_get_position_role': instance.hasGetPositionRole,
      'is_new_user': instance.isNewUser,
      'is_show_public_like': instance.isShowPublicLike,
      'public_like_desc': instance.publicLikeDesc,
      'real_name_status': instance.realNameStatus,
      'real_person_status': instance.realPersonStatus,
    };

AdvancedRecommendData _$AdvancedRecommendDataFromJson(
        Map<String, dynamic> json) =>
    AdvancedRecommendData(
      json['can_op_user'] as bool,
      json['sub_des'] as String,
      (json['advanced_tag_list'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AdvancedRecommendDataToJson(
        AdvancedRecommendData instance) =>
    <String, dynamic>{
      'can_op_user': instance.canOpUser,
      'sub_des': instance.subDes,
      'advanced_tag_list': instance.advancedTagList,
    };
