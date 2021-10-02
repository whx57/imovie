import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:project2/function/video_play1.dart';
import 'package:project2/data/net/get_token.dart';
import 'package:project2/data/net/get_blog_data.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:project2/movie/web_dteail.dart';
import 'package:project2/function/search/search.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:project2/function/video_play.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:project2/function/video_play_history.dart';

var playlist;
var play_num;

class MovieDetail extends StatefulWidget {
  MovieDetail({Key key, this.ur, this.title, this.type}) : super(key: key);

  // final String id;
  final String title;
  final String ur;
  final int type;

  @override
  State<StatefulWidget> createState() {
    return _MovieDetailState();
  }
}

class _MovieDetailState extends State<MovieDetail>
    with AutomaticKeepAliveClientMixin {
  @override
  var _futureBuilderFuture;
  var mlist;
  Future _gerData() async {
    String token = await get_Token();
    var response = await http.get(
      Uri.parse(
          "http://api.vopipi.cn/api/info?type=${widget.type}&onlyStr=${widget.ur}"),
      headers: {"token": token},
    );

    return response.body;
  }

  bool get wantKeepAlive => true;


  void initState() {
    super.initState();
    _futureBuilderFuture = _gerData();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  void play_video() {
    playlist = mlist['sources'];
    play_num = playlist.length;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.lightBlueAccent,
            title: const Text(
              '资源列表',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            children: [
              Text(
                "视频原地址",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: Colors.amber),
              ),
              setupAlertDialoadContainer1(),
              Text(
                "解析视频",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: Colors.amber),
              ),
              SimpleDialogOption(
                  onPressed: () {},
                  child: Center(
                    child: Text(
                      "视频解析：部分视频解析可能存在问题！！！",
                    ),
                  )),
              setupAlertDialoadContainer(),
            ],
          );
        });
  }

  Widget setupAlertDialoadContainer() {

    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: play_num,
        itemBuilder: (BuildContext context, int index) {
          return SingleChildScrollView(
            child: InkWell(
                child: ListTile(
              title: Text(
                '${playlist[index]['Name']}',
                textAlign: TextAlign.center,
              ),
              onTap: () {
                play_video1(playlist[index]['Url']);

              },
            )),
          );
        },
      ),
    );
  }

  void play_video1(String ur) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.lightBlueAccent,
            title: const Text(
              '解析接口选择',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            children: [
              // Text("解析接口选择"),
              Text(
                "腾讯，电影网，乐视，芒果)",
                style: TextStyle(color: Colors.amber, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              SimpleDialogOption(
                child: Text(
                  "解析接口1",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return
                        // WebDemo(ur: "http://api.myzch.cn/?url="+playlist[0]['Url']);
                        MyApp1(ur: "http://api.myzch.cn/?url=" + ur);
                  }));
                },
              ),
              Text(
                "爱奇艺，以及其它",
                style: TextStyle(color: Colors.amber, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              SimpleDialogOption(
                child: Text(
                  "解析接口2",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return
                        MyApp1(ur: "https://130ak.cn/?v=" + ur);
                  }));
                },
              )
            ],
          );
        });
  }

  bool pan(String a) {
    for (var i in datas) {
      if (i["title"] == a) {
        return true;
      }
    }
    return false;
  }

  Widget setupAlertDialoadContainer1() {

    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: play_num,
        itemBuilder: (BuildContext context, int index) {
          return SingleChildScrollView(
            child: InkWell(
                child: ListTile(
              title: Text(
                '${playlist[index]['Name']}',
                textAlign: TextAlign.center,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return
                      MyApp2(ur: playlist[index]['Url']);
                }));
              },
            )),
          );
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
      body: RefreshIndicator(
        onRefresh: _gerData,
        child: FutureBuilder(
          builder: _buildFuture,
          future: _futureBuilderFuture,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: play_video,
        tooltip: 'Increment',
        child: Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print('还没有开始网络请求');
        return Text('还没有开始网络请求');
      case ConnectionState.active:
        print('active');
        return Text('ConnectionState.active');
      case ConnectionState.waiting:
        print('waiting');
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        print('done');
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _createListView(context, snapshot); //////////////
      default:
        return Text('还没有开始网络请求');
    }
  }

  Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {
    var mlist1 = snapshot.data; ////////////
    Map<String, dynamic> re2 = json.decode(mlist1);
    mlist = re2['data'];
    return Column(
      children: <Widget>[
        CachedNetworkImage(
            imageUrl: mlist['imgUrl'],
            imageBuilder: (context, imageProvider) => Card(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 260,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fitHeight),
                    ),
                  ),
                  color: Colors.white38,
                )),

        Column(
          children: <Widget>[
            Divider(),
            Text(
              '地区：${mlist['area']}',
              style: TextStyle(fontSize: 20),
            ),
            Divider(),
            Text(
              '年份：${mlist['years']}',
              style: TextStyle(fontSize: 20),
            ),
            Divider(),
            Text(
              '豆瓣评分：${mlist['score']}',
              style: TextStyle(fontSize: 20),
            ),
            Divider(),
            Container(
              child: ListView(
                children: [
                  Text(
                    "简介： " + mlist['desc'],
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              height: 290,
            )
          ],
        )
      ],
    );
  }
}
