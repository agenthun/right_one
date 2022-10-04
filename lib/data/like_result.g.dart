// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeResult _$LikeResultFromJson(Map<String, dynamic> json) => LikeResult(
      json['like_each_other'] as bool,
      json['is_first_heartbeat'] as bool,
    );

Map<String, dynamic> _$LikeResultToJson(LikeResult instance) =>
    <String, dynamic>{
      'like_each_other': instance.likeEachOther,
      'is_first_heartbeat': instance.isFirstHeartbeat,
    };
