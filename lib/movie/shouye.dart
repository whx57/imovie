import 'package:flutter/material.dart';

import 'movie_card//more_home.dart';
import 'movie_scroll.dart';

import 'dart:ui';

import 'other_source.dart';

List scolist1 = [];
List scolist2 = [];

class homebody extends StatelessWidget {
  const homebody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        HomeBodyArea(),
      ],
    );
  }
}

class HomeBodyArea extends StatelessWidget {
  const HomeBodyArea({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, right: 5, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '今日推荐',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  child: Text(
                    '更多',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext ctx) {
                      return mote_home();
                    }));
                  },
                ),
              ],
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Padding(
              padding: EdgeInsets.only(top: 10, right: 15, left: 15, bottom: 5),
              child: Movie_Scroll(),
            ),
          ),
          Text(
            "资源列表",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black87, fontSize: 30),
          ),
          Center(
            child: Column(
              children: <Widget>[
                Divider(
                  thickness: 14,
                ),
                Text(
                  "部分链接存在广告，请见谅",
                  style: TextStyle(color: Colors.black38),
                ),
                Center(
                  child: Container(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: scolist1.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Wangye(name: scolist1[index]);
                        }),
                  ),
                ),
                Divider(),
                Text("影视解析聚力"),
                Center(
                  child: Container(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: scolist2.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Wangye(name: scolist2[index]);
                        }),
                  ),
                ),
                Divider(
                  thickness: 14,
                ),
              ],
            ),
          )

          // )
        ],
      ),
    ));
  }
}
