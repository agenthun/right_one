// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heart_beat_me_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeartBeatMeList _$HeartBeatMeListFromJson(Map<String, dynamic> json) =>
    HeartBeatMeList(
      json['total'] as int,
      (json['heartbeat_me_list'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$HeartBeatMeListToJson(HeartBeatMeList instance) =>
    <String, dynamic>{
      'total': instance.total,
      'heartbeat_me_list': instance.list,
    };
