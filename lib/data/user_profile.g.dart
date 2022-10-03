// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      json['avatar'] as String,
      json['nickname'] as String,
      json['is_owner'] as bool,
      json['address'] as String,
      json['sex_des'] as String,
      json['sex'] as String,
      json['age'] as int,
      json['constellation'] as String,
      json['is_cancellation'] as bool,
      json['real_name_status'] as String,
      json['real_person_status'] as String,
      json['is_vip'] as bool,
      UserStage.fromJson(json['stage']),
      json['fuser_status'] as String,
      json['has_king_card'] as bool,
      UserPrivacy.fromJson(json['privacy']),
      json['has_privilege'] as bool,
      json['has_tag'] as bool,
      (json['tag_list'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      UserContactInfo.fromJson(json['contact_info_list']),
      UserBasicInfo.fromJson(json['basic_info_list']),
      UserMoreInfo.fromJson(json['more_info_list']),
      json['has_audio'] as bool,
      json['audio_info'],
      json['check_wechat_error'] as bool,
      json['is_cp_candidate'] as bool,
      json['is_black'] as bool,
      json['is_subscribe'] as bool,
      json['is_new_user'] as bool,
      WechatData.fromJson(json['unlock_wechat_data']),
      json['give_special_heartbeat'] as bool,
      json['in_audit'] as bool,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'nickname': instance.nickname,
      'is_owner': instance.isOwner,
      'address': instance.address,
      'sex_des': instance.sexDes,
      'sex': instance.sex,
      'age': instance.age,
      'constellation': instance.constellation,
      'is_cancellation': instance.isCancellation,
      'real_name_status': instance.realNameStatus,
      'real_person_status': instance.realPersonStatus,
      'is_vip': instance.isVip,
      'stage': instance.stage,
      'fuser_status': instance.fuserStatus,
      'has_king_card': instance.hasKingCard,
      'privacy': instance.privacy,
      'has_privilege': instance.hasPrivilege,
      'has_tag': instance.hasTag,
      'tag_list': instance.tagList,
      'contact_info_list': instance.contactInfo,
      'basic_info_list': instance.basicInfo,
      'more_info_list': instance.moreInfo,
      'has_audio': instance.hasAudio,
      'audio_info': instance.audioInfo,
      'check_wechat_error': instance.checkWechatError,
      'is_cp_candidate': instance.isCpCandidate,
      'is_black': instance.isBlack,
      'is_subscribe': instance.isSubscribe,
      'is_new_user': instance.isNewUser,
      'unlock_wechat_data': instance.unlockWechatData,
      'give_special_heartbeat': instance.giveSpecialHeartbeat,
      'in_audit': instance.inAudit,
    };

UserStage _$UserStageFromJson(Map<String, dynamic> json) => UserStage(
      json['candidate'] as String?,
      json['apply'] as String?,
      json['type'] as String?,
    );

Map<String, dynamic> _$UserStageToJson(UserStage instance) => <String, dynamic>{
      'candidate': instance.candidate,
      'apply': instance.apply,
      'type': instance.type,
    };

UserPrivacy _$UserPrivacyFromJson(Map<String, dynamic> json) => UserPrivacy(
      UserLifePhoto.fromJson(json['life_photo']),
      UserPrivacyDetail.fromJson(json['privacy_info']),
    );

Map<String, dynamic> _$UserPrivacyToJson(UserPrivacy instance) =>
    <String, dynamic>{
      'life_photo': instance.photo,
      'privacy_info': instance.detail,
    };

UserLifePhoto _$UserLifePhotoFromJson(Map<String, dynamic> json) =>
    UserLifePhoto(
      json['can_view'] as bool,
      json['privacy_des'] as String,
      json['data'] as String?,
    );

Map<String, dynamic> _$UserLifePhotoToJson(UserLifePhoto instance) =>
    <String, dynamic>{
      'can_view': instance.canView,
      'privacy_des': instance.privacyDes,
      'data': instance.data,
    };

UserPrivacyDetail _$UserPrivacyDetailFromJson(Map<String, dynamic> json) =>
    UserPrivacyDetail(
      json['can_view'] as bool,
      json['privacy_des'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$UserPrivacyDetailToJson(UserPrivacyDetail instance) =>
    <String, dynamic>{
      'can_view': instance.canView,
      'privacy_des': instance.privacyDes,
      'data': instance.data,
    };

UserContactInfo _$UserContactInfoFromJson(Map<String, dynamic> json) =>
    UserContactInfo(
      json['title'] as String,
      json['has_info'] as bool,
    );

Map<String, dynamic> _$UserContactInfoToJson(UserContactInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'has_info': instance.hasInfo,
    };

UserBasicInfo _$UserBasicInfoFromJson(Map<String, dynamic> json) =>
    UserBasicInfo(
      json['title'] as String,
      json['des_info_map'] as Map<String, dynamic>?,
      json['has_info'] as bool,
    );

Map<String, dynamic> _$UserBasicInfoToJson(UserBasicInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'des_info_map': instance.descInfoMap,
      'has_info': instance.hasInfo,
    };

UserMoreInfo _$UserMoreInfoFromJson(Map<String, dynamic> json) => UserMoreInfo(
      json['title'] as String,
      json['des_info_map'] as Map<String, dynamic>?,
      json['has_info'] as bool,
    );

Map<String, dynamic> _$UserMoreInfoToJson(UserMoreInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'des_info_map': instance.descInfoMap,
      'has_info': instance.hasInfo,
    };

UserAudioInfo _$UserAudioInfoFromJson(Map<String, dynamic> json) =>
    UserAudioInfo(
      json['audio_url'] as String,
      json['audio_time_total'] as int,
      json['main_audio_result'] as Map<String, dynamic>,
      json['deputy_audio_result'] as Map<String, dynamic>,
      json['has_audio'] as bool,
    );

Map<String, dynamic> _$UserAudioInfoToJson(UserAudioInfo instance) =>
    <String, dynamic>{
      'audio_url': instance.audioUrl,
      'audio_time_total': instance.audioTimeTotal,
      'main_audio_result': instance.mainAudioResult,
      'deputy_audio_result': instance.deputyAudioResult,
      'has_audio': instance.hasAudio,
    };

WechatData _$WechatDataFromJson(Map<String, dynamic> json) => WechatData(
      json['is_show'] as bool,
      json['can_unlock'] as bool,
      json['btn_type'] as String,
      json['des'] as String,
      json['unlock_tip'] as String,
      json['has_unlock'] as bool,
      json['audit_status'] as String,
    );

Map<String, dynamic> _$WechatDataToJson(WechatData instance) =>
    <String, dynamic>{
      'is_show': instance.isShow,
      'can_unlock': instance.canUnlock,
      'btn_type': instance.btnType,
      'des': instance.des,
      'unlock_tip': instance.unlockTip,
      'has_unlock': instance.hasUnlock,
      'audit_status': instance.auditStatus,
    };
