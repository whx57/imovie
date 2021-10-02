import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:project2/test/detail.dart';
import 'package:project2/movie/web_dteail.dart';

List<VideoItem> datas = <VideoItem>[];

class VideoItem {
  String name;
  String cover;
  String rate;
  String ur;

  VideoItem({this.name, this.cover, this.rate, this.ur}) : super();
}

class Secondpage extends StatefulWidget {
  @override
  State<Secondpage> createState() {
    return MyFullWidgetState();
  }
}

class MyFullWidgetState extends State<Secondpage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  int pagesize = 20;
  var mlist = [];
  var total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext ctx) {
              return

                  WebDemo(ur: datas[index].ur);
            }));
          },
          child: Card(
            child: ListTile(
              leading: Image.network(datas[index].cover),
              subtitle: Text(
                datas[index].rate,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              title: Text(
                datas[index].name,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        );
      },
      itemCount: datas.length,
    ));
  }

  @override
  void initState() {
    //下面的链接豆瓣保存电影信息的链接，会实时更新
    int offest = (page - 1) * pagesize;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

getdata(int offset) {
  Dio()
      .get("https://movie.douban.com/j/search_subjects?type=movie&tag=%E7%8"
          "3%AD%E9%97%A8&sort=recommend&page_limit=20&page_start=$offset")
      .then((response) {
    Map data = response.data;
    List subjects = data["subjects"];
    datas.clear();
    subjects.forEach((item) {
      datas.add(VideoItem(
          name: item["title"],
          cover: item["cover"],
          rate: item["rate"],
          ur: item['url']));
    });
  });
}
