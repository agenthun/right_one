import 'package:json_annotation/json_annotation.dart';
import 'package:right_one/api/api_const.dart';
import 'package:right_one/data/cp_candidate_wrapper.dart';

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

  List<CpCandidateWrapper> get cpCandidateWrapperList {
    var avatarUrlPrefix =
        "https://u-cdn.myrightone.com/puppy/wcp/resource/image/";
    var result =
        list?.where((element) => element["is_current"] ?? false).map((e) {
              String avatar = e["avatar"] ?? "";
              int? uid;
              if (avatar.contains(avatarUrlPrefix)) {
                var end = avatar.lastIndexOf("/");
                var start = avatarUrlPrefix.length;
                uid = int.tryParse(avatar.substring(start, end));
              }
              return CpCandidateWrapper(
                  uid, heart_beat_me, avatar, "匿名", "她很心动", null);
            }) ??
            List.empty();
    return List.from(result);
  }

  factory HeartBeatMeList.fromJson(dynamic json) =>
      _$HeartBeatMeListFromJson(json);

  dynamic toJson() => _$HeartBeatMeListToJson(this);
}
