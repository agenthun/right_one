// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      json['data'],
      json['message'] as String,
      json['code'] as int,
      json['server_time'] as int,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'code': instance.code,
      'server_time': instance.serverTime,
    };
