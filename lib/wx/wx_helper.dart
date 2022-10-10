import 'dart:developer';

import 'package:fluwx/fluwx.dart';

class WxHelper {
  static final WxHelper _instance = WxHelper._init();

  factory WxHelper() => _instance;

  WxHelper._init();

  Future<void> initFluwx() async {
    await registerWxApi(
      appId: 'wx2d5eb1ff5edb5877',
      doOnAndroid: true,
      doOnIOS: true,
      universalLink:
          'https://servicewechat.com/wx2d5eb1ff5edb5877/216/page-frame.html',
    );
    var result = await isWeChatInstalled;
    log('WxHelper, is installed $result');
  }

  Future<void> test() async {
    bool? success = await startLog(logLevel: WXLogLevel.NORMAL);
    log('WxHelper, startLog:$success\n');
    sendWeChatAuth(
      scope: 'snsapi_userinfo',
      state: 'wechat_sdk_demo_test',
    ).then((data) {
      log('WxHelper, sendWeChatAuth $data');
    });
  }
}
