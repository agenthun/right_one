// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cp_candidate_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CpCandidateList _$CpCandidateListFromJson(Map<String, dynamic> json) =>
    CpCandidateList(
      (json['list'] as List<dynamic>?)
          ?.map((e) => CpCandidate.fromJson(e))
          .toList(),
    );

Map<String, dynamic> _$CpCandidateListToJson(CpCandidateList instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

CpCandidate _$CpCandidateFromJson(Map<String, dynamic> json) => CpCandidate(
      json['fuid'] as int,
      json['type'] as String,
      json['icon_data'] as Map<String, dynamic>,
      json['info_data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$CpCandidateToJson(CpCandidate instance) =>
    <String, dynamic>{
      'fuid': instance.fuid,
      'type': instance.type,
      'icon_data': instance.iconData,
      'info_data': instance.infoData,
    };
