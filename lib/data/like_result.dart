import 'package:json_annotation/json_annotation.dart';

part 'like_result.g.dart';

@JsonSerializable()
class LikeResult {
  @JsonKey(name: "like_each_other")
  late bool likeEachOther;
  @JsonKey(name: "is_first_heartbeat")
  late bool isFirstHeartbeat;

  LikeResult(this.likeEachOther, this.isFirstHeartbeat);

  factory LikeResult.fromJson(dynamic json) => _$LikeResultFromJson(json);

  dynamic toJson() => _$LikeResultToJson(this);
}
