import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project2/movie/detail1.dart';

List datas = [];
var le = 0;
var _storageString;

/**
 * 利用文件存储数据
 */
saveString() async {
  final file = await getFile('file1.text');
  var his = "";
  //写入字符串
  for (var i in datas) {
    his = his + "&" + i.toString();
  }
  print("---------------save sucess----------------------------${his}");
  file.writeAsString(his);
}

/**
 * 初始化文件路径
 */
Future<File> getFile(String fileName) async {
  //获取应用文件目录类似于Ios的NSDocumentDirectory和Android上的 AppData目录
  final fileDirectory = await getApplicationDocumentsDirectory();

  //获取存储路径
  final filePath = fileDirectory.path;

  //或者file对象（操作文件记得导入import 'dart:io'）
  return new File(filePath + "/" + fileName);
}

/**
 * 获取存在文件中的数据
 */
Future getString() async {
  print("---------开始get---------");
  final file = await getFile('file1.text');
  var filePath = file.path;
  print("object----------------------");
  file.readAsString().then((String value) {

    _storageString = value;
  });

  print("---------开始get---------");
  List<String> sss = _storageString.split('&');

  var datas1 = [];
  for (var i in sss) {


    if (i == '') continue;
    i = i.replaceAll('{', '');
    i = i.replaceAll('}', '');
    var map = new Map();
    List<String> sss1 = i.split(',');
    for (var g in sss1) {
      List<String> sss2 = g.split(': ');

      map[sss2[0].replaceAll(new RegExp(r"\s+\b|\b\s"), "")] =
          sss2[1].replaceAll(new RegExp(r"\s+\b|\b\s"), "");
      // map.addEntries(new MapEntry(1,"哈哈哈"))
    }
    // Map<String, dynamic> user = json.decode(i);
    datas1.add(map);
  }

  datas = datas1;
  le = datas.length;
}

class play_History extends StatefulWidget {
  // const play_History({Key? key}) : super(key: key);
  @override
  _play_HistoryState createState() => _play_HistoryState();
}

class _play_HistoryState extends State<play_History> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("播放历史"),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext ctx) {
                  return new MovieDetail(
                    ur: datas[index]['onlyStr'],
                    title: datas[index]['title'],
                    type: int.parse(datas[index]['cateId']),
                  );
                }));
              },
              child: Card(
                child: ListTile(
                  leading: Image.network(datas[index]['imgUrl']),
                  subtitle: Text(
                    datas[index]['score'],
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  title: Text(
                    datas[index]['title'],
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
            );
          },
          itemCount: datas.length,
        ));
  }
}
