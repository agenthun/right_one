import 'package:json_annotation/json_annotation.dart';

part 'cp_candidate_list.g.dart';

@JsonSerializable()
class CpCandidateList {
  @JsonKey(name: "list")
  late List<CpCandidate>? list;

  CpCandidateList(this.list);

  factory CpCandidateList.fromJson(dynamic json) =>
      _$CpCandidateListFromJson(json);

  dynamic toJson() => _$CpCandidateListToJson(this);
}

@JsonSerializable()
class CpCandidate {
  @JsonKey(name: "fuid")
  late int fuid;
  @JsonKey(name: "type")
  late String type;
  @JsonKey(name: "icon_data")
  late Map<String, dynamic> iconData;
  @JsonKey(name: "info_data")
  late Map<String, dynamic> infoData;

  CpCandidate(this.fuid, this.type, this.iconData, this.infoData);

  String get cpSource => iconData["tip"];

  String get avatar => iconData["url"];

  String get nickname => infoData["title"];

  String get cpStateDesc => infoData["des"];

  factory CpCandidate.fromJson(dynamic json) => _$CpCandidateFromJson(json);

  dynamic toJson() => _$CpCandidateToJson(this);
}
