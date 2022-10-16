import 'package:right_one/db/kv.dart';

const yizhoucp_host = "https://w.yizhoucp.cn";
const heart_beat_me = "heart_beat_me";

String get token => KvHolder().getKv().get("token",
    defaultValue:
        "1560976019693678_5247899_1691849729_85a3407a5e71480f1d2e3852c02eeff6");

set token(String? value) {
  if (value == null || value.isEmpty) return;
  KvHolder().getKv().put("token", value);
}
