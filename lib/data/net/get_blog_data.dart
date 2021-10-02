import 'dart:convert';
import 'package:project2/movie/movie_card/movies.dart';
import 'package:http/http.dart' as http;
import 'package:project2/movie/movie_scroll.dart';
import 'get_token.dart';
import 'package:project2/movie/shouye.dart';

get_Blog_data(String prmt) async {
  var response = await http.get(
    Uri.parse("https://lab.kurihada.com/better/${prmt}"),
  );

  String token = await get_Token();
  var result = response.body;
  Map<String, dynamic> re2 = json.decode(result);
  List<Movie> scolist1 = [];



  Future _gerData(String key) async {
    var response1 = await http.get(
      Uri.parse("http://api.vopipi.cn/api/info?type=1&onlyStr=${key}"),
      headers: {"token": token},
    );
    var result1 = response1.body;
    Map<String, dynamic> re3 = json.decode(result1);

    return re3['data']['desc'];
  }

  re2.forEach((key, value) async {
    // print(value);
    String intr = await _gerData(value[0]);

    Movie inf = new Movie(
        name: key,
        onlyStr: value[0],
        title: value[1],
        cateId: int.parse(value[2]),
        poster: value[3],
        date: value[4],
        intro: intr);
    scolist1.add(inf);
  });

  scolist = scolist1;
}

get_Blog_data1(String prmt) async {
  var response = await http.get(
    Uri.parse("https://lab.kurihada.com/better/${prmt}"),
  );

  //
  var result = response.body;
  Map<String, dynamic> re2 = json.decode(result);
  List scolist3 = [];
  List scolist4 = [];

  int i = 0;

  re2.forEach((key, value) {
    var value1 = value.split('"');

    var value2 = value1[1];

    if (value2.startsWith("影视") || value2.startsWith("电影")) {
      scolist3.add(value2);
    } else {
      scolist4.add(value2);
    }
    i++;
  });

  scolist1 = scolist4;
  scolist2 = scolist3;
}

void main() {
  print(get_Blog_data("movie"));
}
