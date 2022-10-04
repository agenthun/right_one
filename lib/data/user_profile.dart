import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  @JsonKey(name: "avatar")
  late String avatar;
  @JsonKey(name: "nickname")
  late String nickname;
  @JsonKey(name: "is_owner")
  late bool isOwner;
  @JsonKey(name: "address")
  late String address;
  @JsonKey(name: "sex_des")
  late String sexDes;
  @JsonKey(name: "sex")
  late String sex;
  @JsonKey(name: "age")
  late int age;
  @JsonKey(name: "constellation")
  late String constellation;
  @JsonKey(name: "is_cancellation")
  late bool isCancellation;
  @JsonKey(name: "real_name_status")
  late String realNameStatus;
  @JsonKey(name: "real_person_status")
  late String realPersonStatus;
  @JsonKey(name: "is_vip")
  late bool isVip;
  @JsonKey(name: "stage")
  late UserStage stage;
  @JsonKey(name: "fuser_status")
  late String fuserStatus;
  @JsonKey(name: "has_king_card")
  late bool hasKingCard;
  @JsonKey(name: "privacy")
  late UserPrivacy privacy;
  @JsonKey(name: "has_privilege")
  late bool hasPrivilege;
  @JsonKey(name: "has_tag")
  late bool hasTag;
  @JsonKey(name: "tag_list")
  late List<Map<String, dynamic>> tagList;
  @JsonKey(name: "contact_info_list")
  late UserContactInfo contactInfo;
  @JsonKey(name: "basic_info_list")
  late UserBasicInfo basicInfo;
  @JsonKey(name: "more_info_list")
  late UserMoreInfo moreInfo;
  @JsonKey(name: "has_audio")
  late bool hasAudio;
  @JsonKey(name: "audio_info")
  late dynamic audioInfo;
  @JsonKey(name: "check_wechat_error")
  late bool checkWechatError;
  @JsonKey(name: "is_cp_candidate")
  late bool isCpCandidate;
  @JsonKey(name: "is_black")
  late bool isBlack;
  @JsonKey(name: "is_subscribe")
  late bool isSubscribe;
  @JsonKey(name: "is_new_user")
  late bool isNewUser;
  @JsonKey(name: "unlock_wechat_data")
  late WechatData unlockWechatData;
  @JsonKey(name: "give_special_heartbeat")
  late bool giveSpecialHeartbeat;
  @JsonKey(name: "in_audit")
  late bool inAudit;

  late int? uid;

  UserProfile(
      this.avatar,
      this.nickname,
      this.isOwner,
      this.address,
      this.sexDes,
      this.sex,
      this.age,
      this.constellation,
      this.isCancellation,
      this.realNameStatus,
      this.realPersonStatus,
      this.isVip,
      this.stage,
      this.fuserStatus,
      this.hasKingCard,
      this.privacy,
      this.hasPrivilege,
      this.hasTag,
      this.tagList,
      this.contactInfo,
      this.basicInfo,
      this.moreInfo,
      this.hasAudio,
      this.audioInfo,
      this.checkWechatError,
      this.isCpCandidate,
      this.isBlack,
      this.isSubscribe,
      this.isNewUser,
      this.unlockWechatData,
      this.giveSpecialHeartbeat,
      this.inAudit,
      this.uid);

  String get headerPhoto {
    var photo = privacy.photo.data;
    if (photo == null || photo.isEmpty) return avatar;
    return photo;
  }

  List<String> get tagKeys {
    if (hasTag) {
      return List.from(tagList.map((e) => e["keyword"]));
    }
    return List.empty();
  }

  UserAudioInfo? get userAudioInfo {
    if (audioInfo != null &&
        audioInfo is Map &&
        (audioInfo as Map).isNotEmpty) {
      return UserAudioInfo.fromJson(audioInfo);
    }
    return null;
  }

  factory UserProfile.fromJson(dynamic json) => _$UserProfileFromJson(json);

  dynamic toJson() => _$UserProfileToJson(this);
}

@JsonSerializable()
class UserStage {
  @JsonKey(name: "candidate")
  late String? candidate;
  @JsonKey(name: "apply")
  late String? apply;
  @JsonKey(name: "type")
  late String? type;

  UserStage(this.candidate, this.apply, this.type);

  factory UserStage.fromJson(dynamic json) => _$UserStageFromJson(json);

  dynamic toJson() => _$UserStageToJson(this);
}

@JsonSerializable()
class UserPrivacy {
  @JsonKey(name: "life_photo")
  late UserLifePhoto photo;
  @JsonKey(name: "privacy_info")
  late UserPrivacyDetail detail;

  UserPrivacy(this.photo, this.detail);

  factory UserPrivacy.fromJson(dynamic json) => _$UserPrivacyFromJson(json);

  dynamic toJson() => _$UserPrivacyToJson(this);
}

@JsonSerializable()
class UserLifePhoto {
  @JsonKey(name: "can_view")
  late bool canView;
  @JsonKey(name: "privacy_des")
  late String privacyDes;
  @JsonKey(name: "data")
  late String? data;

  UserLifePhoto(this.canView, this.privacyDes, this.data);

  factory UserLifePhoto.fromJson(dynamic json) => _$UserLifePhotoFromJson(json);

  dynamic toJson() => _$UserLifePhotoToJson(this);
}

@JsonSerializable()
class UserPrivacyDetail {
  @JsonKey(name: "can_view")
  late bool canView;
  @JsonKey(name: "privacy_des")
  late String privacyDes;
  @JsonKey(name: "data")
  late List<Map<String, dynamic>> data;

  UserPrivacyDetail(this.canView, this.privacyDes, this.data);

  dynamic get height => _attr("height");

  dynamic get annualIncome => _attr("annual_income");

  dynamic get career => _attr("career");

  dynamic get loveStory => _attr("love_story");

  dynamic _attr(String key) {
    var item = data.firstWhere((it) => it["privacy_key"] == key);
    return item["data"];
  }

  factory UserPrivacyDetail.fromJson(dynamic json) =>
      _$UserPrivacyDetailFromJson(json);

  dynamic toJson() => _$UserPrivacyDetailToJson(this);
}

@JsonSerializable()
class UserContactInfo {
  @JsonKey(name: "title")
  late String title;
  @JsonKey(name: "has_info")
  late bool hasInfo;

  UserContactInfo(this.title, this.hasInfo);

  factory UserContactInfo.fromJson(dynamic json) =>
      _$UserContactInfoFromJson(json);

  dynamic toJson() => _$UserContactInfoToJson(this);
}

@JsonSerializable()
class UserBasicInfo {
  @JsonKey(name: "title")
  late String title;
  @JsonKey(name: "des_info_map")
  late Map<String, dynamic>? descInfoMap;
  @JsonKey(name: "has_info")
  late bool hasInfo;

  UserBasicInfo(this.title, this.descInfoMap, this.hasInfo);

  dynamic get hometown => _attr("hometown");

  dynamic get school => _attr("school");

  dynamic get work => _attr("work_type");

  dynamic _attr(String key) {
    return descInfoMap?[key]?["info"];
  }

  factory UserBasicInfo.fromJson(dynamic json) => _$UserBasicInfoFromJson(json);

  dynamic toJson() => _$UserBasicInfoToJson(this);
}

@JsonSerializable()
class UserMoreInfo {
  @JsonKey(name: "title")
  late String title;
  @JsonKey(name: "des_info_map")
  late Map<String, dynamic>? descInfoMap;
  @JsonKey(name: "has_info")
  late bool hasInfo;

  UserMoreInfo(this.title, this.descInfoMap, this.hasInfo);

  dynamic get appearance => _attr("appearance");

  dynamic get future => _attr("future");

  dynamic get growUp => _attr("growup");

  dynamic get romantic => _attr("romantic");

  dynamic get travel => _attr("travel");

  dynamic get whatCp => _attr("what_cp");

  dynamic _attr(String key) {
    return descInfoMap?[key]?["info"];
  }

  factory UserMoreInfo.fromJson(dynamic json) => _$UserMoreInfoFromJson(json);

  dynamic toJson() => _$UserMoreInfoToJson(this);
}

@JsonSerializable()
class UserAudioInfo {
  @JsonKey(name: "audio_url")
  late String audioUrl;
  @JsonKey(name: "audio_time_total")
  late int audioTimeTotal;
  @JsonKey(name: "main_audio_result")
  late Map<String, dynamic> mainAudioResult;
  @JsonKey(name: "deputy_audio_result")
  late Map<String, dynamic> deputyAudioResult;
  @JsonKey(name: "has_audio")
  late bool hasAudio;

  UserAudioInfo(this.audioUrl, this.audioTimeTotal, this.mainAudioResult,
      this.deputyAudioResult, this.hasAudio);

  String get mainAudioDesc => _attr(mainAudioResult);

  String get deputyAudioDesc => _attr(deputyAudioResult);

  dynamic _attr(Map<String, dynamic> map) {
    return "${map["type"]} ${map["ratio"]}";
  }

  factory UserAudioInfo.fromJson(dynamic json) => _$UserAudioInfoFromJson(json);

  dynamic toJson() => _$UserAudioInfoToJson(this);
}

@JsonSerializable()
class WechatData {
  @JsonKey(name: "is_show")
  late bool isShow;
  @JsonKey(name: "can_unlock")
  late bool canUnlock;
  @JsonKey(name: "btn_type")
  late String btnType;
  @JsonKey(name: "des")
  late String des;
  @JsonKey(name: "unlock_tip")
  late String unlockTip;
  @JsonKey(name: "has_unlock")
  late bool hasUnlock;
  @JsonKey(name: "audit_status")
  late String auditStatus;

  WechatData(this.isShow, this.canUnlock, this.btnType, this.des,
      this.unlockTip, this.hasUnlock, this.auditStatus);

  factory WechatData.fromJson(dynamic json) => _$WechatDataFromJson(json);

  dynamic toJson() => _$WechatDataToJson(this);
}
