import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:project2/movie/detail1.dart';
import 'package:http/http.dart' as http;
import 'package:project2/data/net/get_token.dart';
import 'package:project2/data/net/get_blog_data.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';
import 'package:project2/function/video_play_history.dart';
import 'package:cached_network_image/cached_network_image.dart';

Dio dio = new Dio();

class MovieList extends StatefulWidget {
  MovieList({Key key, this.mt}) : super(key: key);

  final String mt;

  @override
  State<StatefulWidget> createState() {
    return new _MovieListState();
  }
}

class _MovieListState extends State<MovieList> {
  var mlist = [];
  var total = 0;
  var mitem;
  var _futureBuilderFuture; /////////////////
  @override

  Future _gerData() async {
    //////////////
    String token = await get_Token();
    var response = await http.get(
      Uri.parse("http://api.vopipi.cn/api/search?wd=${widget.mt}"),
      headers: {"token": token},
    );
    // super.initState();
    return response.body;
  }

  void initState() {
    _futureBuilderFuture = _gerData(); //////////////////
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          RefreshIndicator(
            ///////////////
            onRefresh: _gerData,
            child: FutureBuilder(
              builder: _buildFuture,
              future: _futureBuilderFuture,
            ),
          ),
          // Positioned(/////////////////////////////////悬浮按钮-结果排序（未完成）
          //   right: 33,
          //   bottom: 33,
          //   //悬浮按钮
          //   child: RoteFloatingButton(
          //     //菜单图标组
          //     iconList: [
          //
          //       // Icon(Icons.message),
          //       Icon(Icons.trending_up_outlined),
          //       Icon(Icons.trending_down_outlined),
          //     ],
          //     //点击事件回调
          //     clickCallback: (int index){
          //       if(index==0){
          //         print("-------------------up");
          //
          //         // _futureBuilderFuture = _gerData();
          //         // mlist.sort((right,left)=>right['score'].compareTo(left['score']));
          //
          //       }
          //       else {
          //         _futureBuilderFuture = _gerData();
          //         // Navigator.pop(context);
          //
          //         print("-------------------down");
          //         // mlist.sort((left,right)=>right['score'].compareTo(left['score']));
          //       }
          //
          //
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    ///////////////
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
        // print("-----------------检查检查-----------------");
        var mlist1 = snapshot.data;
        Map<String, dynamic> re2 = json.decode(mlist1);
        return _createListView(context, snapshot); //////////////
      default:
        return Text('还没有开始网络请求');
    }
  }

  bool pan(String a) {
    for (var i in datas) {
      if (i["title"] == a) {
        return true;
      }
    }
    return false;
  }

  Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {
    ////////////////
    var mlist1 = snapshot.data;

    Map<String, dynamic> re2 = json.decode(mlist1);
    mlist = re2['data'];

    mlist.sort((left, right) => right['years'].compareTo(left['years']));

    if (mlist.length == 0) {
      return Container(
        child: Text(
          "抱歉！找不到你需要的资源，我在努力添加更多可能的资源",
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
      );
      // }
    }

    return ListView.builder(
      itemBuilder: (BuildContext ctx, int i) {
        var mitem = mlist[i];

        return GestureDetector(
            onTap: () {
              var mitem1 = new Map.from(mitem);

              mitem1['cateId'] = mitem1['cateId'].toString();
              // if(!datas.contains(mitem)){
              if (!pan(mitem1['title'])) {
                print("加入-----------------------------");

                datas.add(mitem1);
                saveString();
              }

              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext ctx) {
                return new MovieDetail(
                  ur: mitem['onlyStr'],
                  title: mitem['title'],
                  type: mitem['cateId'],
                );
              }));
            },
            child: Card(
              child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      border: Border(top: BorderSide(color: Colors.black12))),
                  child: Row(
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: mitem['imgUrl'],
                        imageBuilder: (context, imageProvider) => Container(
                          padding: EdgeInsets.only(left: 150),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 150,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                '电影名称: ${mitem['title']}',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text('上映时间: ${mitem['years']}年',
                                  style: TextStyle(fontSize: 12)),
                              Text('评分: ${mitem['score']}',
                                  style: TextStyle(fontSize: 12)),
                            ]),
                      )
                    ],
                  )),
            ));
      },
      itemCount: mlist.length,
    );

    // return ListView.builder(
    //   itemBuilder: (BuildContext ctx, int i) {
    //     mitem = mlist[i];
    //     print(i);
    //     print("开始绘制--------------------");
    //     print(mitem);
    //     return GestureDetector(
    //       onTap: () {
    //         print(mitem);
    //         var mitem1 = new Map.from(mitem);
    //         mitem1['cateId'] = mitem1['cateId'].toString();
    //         // if(!datas.contains(mitem)){
    //         if (!pan(mitem1['title'])) {
    //           print("加入-----------------------------");
    //
    //           datas.add(mitem1);
    //           // datas=[];////清空一下
    //           saveString();
    //         }
    //
    //         Navigator.push(context,
    //             MaterialPageRoute(builder: (BuildContext ctx) {
    //           return new MovieDetail(
    //             ur: mitem['onlyStr'],
    //             title: mitem['title'],
    //             type: mitem['cateId'],
    //           );
    //         }));
    //       },
    //       child: Container(
    //           height: 200,
    //           decoration: BoxDecoration(
    //               color: Colors.white10,
    //               border: Border(top: BorderSide(color: Colors.black12))),
    //           child: Row(
    //             children: <Widget>[
    //               Image.network(mitem['imgUrl'],
    //                   width: 130, height: 180, fit: BoxFit.cover),
    //               Container(
    //                 padding: EdgeInsets.only(left: 10),
    //                 height: 150,
    //                 child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: <Widget>[
    //                       Text('电影名称: ${mitem['title']}'),
    //                       Text('上映时间: ${mitem['years']}年'),
    //                       Text('评分: ${mitem['score']}'),
    //                     ]),
    //               )
    //             ],
    //           )),
    //     );
    //   },
    //   itemCount: mlist.length,
    // );////点击出现乱跳转?????
  }
}
