import 'dart:convert';
import 'package:shake_animation_widget/shake_animation_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:project2/movie/detail1.dart';
import 'package:http/http.dart' as http;
import 'package:project2/data/net/get_token.dart';
import 'package:project2/data/net/get_blog_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:project2/function/video_play_history.dart';
Dio dio = new Dio();

class MovieList extends StatefulWidget {
  MovieList({Key key, this.mt}) : super(key: key);

  final String mt;
  @override
  State<StatefulWidget> createState() {
    return new _MovieListState();
  }
}

class _MovieListState extends State<MovieList>
    with AutomaticKeepAliveClientMixin
{
  int page = 1;
  var mlist = [];
  var total = 0;
  @override
  var _futureBuilderFuture; /////////////////
  Future _gerData() async {
    //////////////
    String token = await get_Token();
    var response = await http.get(
      Uri.parse(
          'http://api.vopipi.cn/api/list?type=1&rank=${widget.mt}&page=${page}'),
      headers: {"token": token},
    );

    return response.body;
  }

  Future _gerData1() async {
    //////////////
    String token = await get_Token();
    var response = await http.get(
      Uri.parse(
          'http://api.vopipi.cn/api/list?type=1&rank=${widget.mt}&page=${page}'),
      headers: {"token": token},
    );

    _futureBuilderFuture = response.body;
    return response.body;
  }

  void initState() {
    _futureBuilderFuture = _gerData(); //////////////////
    super.initState();
    // getMovie();
  }

  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        ///////////////
        onRefresh: _gerData,
        child: Container(
          child: Stack(
            children: [
              FutureBuilder(
                builder: _buildFuture,
                future: _futureBuilderFuture,
              ),
              Positioned(
                right: 33,
                bottom: 33,
                //悬浮按钮
                child: RoteFloatingButton(
                  //菜单图标组
                  iconList: [
                    Icon(Icons.arrow_back_ios),
                    // Icon(Icons.message),
                    Icon(Icons.arrow_forward_ios_rounded),
                  ],
                  //点击事件回调
                  clickCallback: (int index) {
                    if (index == 0) {
                      if (page != 1)
                        setState(() {
                          page--;
                          _futureBuilderFuture = _gerData();

                        });
                    } else {
                      setState(() {
                        page++;
                        _futureBuilderFuture = _gerData();

                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
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
  bool pan(String a){
    for(var i in datas){
      if(i["title"]==a){
        return true;
      }
    }
    return false;
  }

  Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {
    var mlist1 = snapshot.data;
    Map<String, dynamic> re2 = json.decode(mlist1);
    mlist = re2['data'];

    return ListView.builder(
      itemBuilder: (BuildContext ctx, int i) {
        var mitem = mlist[i];

        return GestureDetector(
            onTap: () {
              var mitem1=new Map.from(mitem);
              mitem1['cateId']=mitem1['cateId'].toString();
                if(!pan(mitem1['title'])){
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
                                style: TextStyle(fontSize: 15),
                              ),
                              Text('上映时间: ${mitem['hint']}年',
                                  style: TextStyle(fontSize: 15)),
                              Text('评分: ${mitem['score']}',
                                  style: TextStyle(fontSize: 15)),
                            ]),
                      )
                    ],
                  )),
            ));
      },
      itemCount: mlist.length,
    );
  }
  //
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
