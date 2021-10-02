import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project2/movie/list.dart';
import 'package:project2/function/search/search.dart';
import 'package:project2/movie/douban.dart';
import 'package:project2/movie/movie_card//more_home.dart';

import 'package:project2/ads/logining_page.dart';
import 'package:flutter/cupertino.dart';

import 'package:project2/movie/shouye.dart';
import 'package:project2/function/video_play_history.dart';
import 'package:project2/test/net_image_test.dart';
import 'package:project2/movie/high_move/recomd.dart';

class Myhome extends StatefulWidget {
  @override
  _MyhomeState createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome>
    with AutomaticKeepAliveClientMixin
{
  @override
  Brightness brightness = Brightness.light;
  @override
  void initState() {
    // TODO: implement initState
    // play_video();
    Future.delayed(Duration.zero, () {
      this.play_video();
    });
    super.initState();
  }



  Widget build(BuildContext context) {
    // throw UnimplementedError();
    return MaterialApp(
      theme: ThemeData(
        brightness: brightness,
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text("i movie"),
              centerTitle: true,
              actions: <Widget>[
                InkWell(
                  child: Icon(Icons.search),
                  onTap: () {
                    showSearch(context: context, delegate: SearchBarDelegate());
                  },
                )
              ],
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text("code by better"),
                    accountEmail: Text("better57.top"),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://profile.csdnimg.cn/7/C/D/1_hello__bug'),
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fv."
                                "seloger.com%2Fs%2Fwidth%2F800%2Fvisuels%2F1%2F1%2Fn%2Fw%2F11nwkb4gg3xveun515v8k9tvu7tqvu0u7eki31728.jpg&refer=http%3A%2F%2Fv.seloger.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632290503&t=4bfcd4cd73c4d8a5fcfb419f23c3f650"))),
                  ),
                  ListTile(
                    title: Text("反馈"),
                    trailing: Icon(Icons.feedback),
                    onTap: _showMySimpleDialog,
                  ),
                  Divider(),
                  ListTile(
                    title: Text("夜间模式"),
                    trailing: Icon(Icons.settings),
                    onTap: () {
                      _onClick();
                      setState(() {
                        if (brightness == Brightness.dark) {
                          brightness = Brightness.light;
                        } else {
                          brightness = Brightness.dark;
                        }
                      });
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("播放历史"),
                    trailing: Icon(Icons.history_outlined),
                    onTap: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return play_History();
                      }));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("关于"),
                    onTap: _showMySimpleDialog1,
                    trailing: Icon(Icons.movie),
                  ),
                  Divider(),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(color: Colors.black),
              height: 50,
              child: TabBar(
                labelStyle: TextStyle(height: 0),
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.movie),
                    text: "影视聚力",
                  ),
                  Tab(
                    icon: Icon(Icons.movie),
                    text: "豆瓣热映",
                  ),
                  Tab(
                    icon: Icon(Icons.movie),
                    text: "高分电影",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                homebody(),
                // mote_home(),
                Secondpage(),
                // MyApp3(),
                //   TabBarControllerPage()
                FirstPage()
              ],
            ),




          )),
    );


  }

  _onClick() {
    setState() {
      if (brightness == Brightness.dark) {
        brightness = Brightness.light;
      } else {
        brightness = Brightness.dark;
      }
    }
  }




  void play_video() {
    print("ok");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            insetPadding: EdgeInsets.only(left: 18, right: 18,bottom: 20),
            // backgroundColor: Colors.white70,
            children: [
                Container(
                  height: 760,
                  width: 1000,

                  child:
                  mote_home(),
                )
                ,

            ],
          );
        });
  }

  void _showMySimpleDialog1() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.lightBlueAccent,
          title: const Text(
            '关于',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          children: [
            Text(
              "测试版1.1",
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
            Text(
              "更新内容",
              style: TextStyle(color: Colors.amber, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            Text(
              "1.新增了一个解析接口，现在可以播放爱奇艺的视频了",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.left,
            ),
            Text(
              "2.优化了首页界面布局，以及将每日推荐电影数据更换为服务器的数据",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.left,
            ),
            Text(
              "3.新增播放历史功能",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.left,
            ),
          ],
        );
      },
    );
  }

  void _showMySimpleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.lightBlueAccent,
          title: const Text(
            '联系方式',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          children: [
            SimpleDialogOption(
              onPressed: () {
                print('qq:1203162819');
                Navigator.pop(context);
              },
              child: const Text('qq:1203162819', textAlign: TextAlign.center),
            ),
            SimpleDialogOption(
              onPressed: () {
                print('微信');
                Navigator.pop(context);
              },
              child: const Text('微信:w1203162819', textAlign: TextAlign.center),
            ),
            SimpleDialogOption(
              onPressed: () {
                print('邮箱');
                Navigator.pop(context);
              },
              child: const Text('邮箱:better57@126.com',
                  textAlign: TextAlign.center),
            )
          ],
        );
      },
    );
  }




  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
