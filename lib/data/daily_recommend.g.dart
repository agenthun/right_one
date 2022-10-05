// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_recommend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyRecommend _$DailyRecommendFromJson(Map<String, dynamic> json) =>
    DailyRecommend(
      FeaturedRecommendUser.fromJson(json['featured_recommend_user']),
    );

Map<String, dynamic> _$DailyRecommendToJson(DailyRecommend instance) =>
    <String, dynamic>{
      'featured_recommend_user': instance.featuredRecommendUser,
    };

FeaturedRecommendUser _$FeaturedRecommendUserFromJson(
        Map<String, dynamic> json) =>
    FeaturedRecommendUser(
      json['uid'],
      json['avatar'] as String?,
      json['nickname'] as String?,
      json['is_new_user'] as bool?,
      json['user_des'] as String?,
      json['is_waiting_refresh'] as bool,
    );

Map<String, dynamic> _$FeaturedRecommendUserToJson(
        FeaturedRecommendUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'avatar': instance.avatar,
      'nickname': instance.nickname,
      'is_new_user': instance.isNewUser,
      'user_des': instance.userDes,
      'is_waiting_refresh': instance.isWaitingRefresh,
    };
