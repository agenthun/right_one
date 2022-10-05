import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  late dynamic data;
  late String message;
  late int code;
  @JsonKey(name: "server_time")
  late int serverTime;

  Result(this.data, this.message, this.code, this.serverTime);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
