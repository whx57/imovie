import 'dart:async';
import 'package:project2/function/night.dart';
import 'package:flutter/material.dart';
import 'package:project2/movie/home_page.dart';
import 'package:project2/movie/web_dteail.dart';
import 'package:project2/data/net/get_blog_data.dart';
import 'package:project2/movie/douban.dart';
import 'package:project2/function/video_play_history.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;
  int count = 5;
  startTime() async {
    ///////////////加载
    get_Blog_data("movie");
    get_Blog_data1("video?type=link");
    getString();
    ////////////
    getdata(0);
    //设置启动图生效时间
    var _duration = new Duration(seconds: 1);
    new Timer(_duration, () {
      // 空等1秒之后再计时
      _timer = new Timer.periodic(const Duration(milliseconds: 1000), (v) {
        count--;
        if (count == 0) {
          navigationPage();
        } else {
          setState(() {});
        }
      });
      return;
    });
  }

  void navigationPage() {
    getString();
    _timer.cancel();
    Navigator.pushAndRemoveUntil(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return Myhome();
    }), (route) => route == null);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: const Alignment(1.0, -1.0), // 右上角对齐
      children: [
        GestureDetector(
          child: new ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: new Image.asset(
              "assets/images/ad.png", //广告图
              fit: BoxFit.fill,
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext ctx) {
              return
                  WebDemo(ur: "http://www.better57.top/");
            }));
            // navigationPage();
          },
        ),
        new Padding(
          padding: new EdgeInsets.fromLTRB(0.0, 30.0, 10.0, 0.0),
          child: new FlatButton(
            onPressed: () {
              navigationPage();
            },
//            padding: EdgeInsets.all(0.0),
            color: Colors.grey,
            child: new Text(
              "$count 跳过广告",
              style: new TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ),
        )
      ],
    );
  }
}
