import 'package:right_one/db/kv.dart';

const yizhoucp_host = "https://w.yizhoucp.cn";
const heart_beat_me = "heart_beat_me";

String get token => KvHolder().getKv().get("token",
    defaultValue:
        "1560976019693678_5247899_1708178793_4897d1ac1210d2eac1f44f92c660e3ac");

set token(String? value) {
  if (value == null || value.isEmpty) return;
  KvHolder().getKv().put("token", value);
}
