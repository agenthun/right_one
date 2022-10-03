import 'package:json_annotation/json_annotation.dart';

part 'heart_beat_me_list.g.dart';

@JsonSerializable()
class HeartBeatMeList {
  @JsonKey(name: "total")
  late int total;

  @JsonKey(name: "heartbeat_me_list")
  late List<Map<String, dynamic>>? list;

  HeartBeatMeList(this.total, this.list);

  List<String> get avatarList {
    return List.from(list?.map((e) => e["avatar"] ?? "") ?? List.empty());
  }

  factory HeartBeatMeList.fromJson(dynamic json) =>
      _$HeartBeatMeListFromJson(json);

  dynamic toJson() => _$HeartBeatMeListToJson(this);
}
