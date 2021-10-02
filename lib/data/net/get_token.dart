import 'dart:convert';

import 'package:http/http.dart' as http;

get_Token() async {
  var response = await http.get(
    Uri.parse("http://api.vopipi.cn/api/auth"),
  );
  //
  var result = response.body;
  Map<String, dynamic> re2 = json.decode(result);

  String res = re2['data']["token"];
  return res;
}
