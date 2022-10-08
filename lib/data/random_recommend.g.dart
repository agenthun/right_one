// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'random_recommend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RandomRecommend _$RandomRecommendFromJson(Map<String, dynamic> json) =>
    RandomRecommend(
      json['new_login_model'] as bool,
      RandomRecommendUserInfo.fromJson(json['user_info']),
    );

Map<String, dynamic> _$RandomRecommendToJson(RandomRecommend instance) =>
    <String, dynamic>{
      'new_login_model': instance.newLoginModel,
      'user_info': instance.userInfo,
    };

RandomRecommendUserInfo _$RandomRecommendUserInfoFromJson(
        Map<String, dynamic> json) =>
    RandomRecommendUserInfo(
      json['uid'] as int,
      json['avatar'] as String,
    );

Map<String, dynamic> _$RandomRecommendUserInfoToJson(
        RandomRecommendUserInfo instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'avatar': instance.avatar,
    };
