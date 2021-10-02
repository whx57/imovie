import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:project2/function/video_play1.dart';

import 'package:project2/data/link.dart';

class Wangye extends StatelessWidget {
  const Wangye({Key key, this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    String link = getlink[name];
    final _width = window.physicalSize.width;
    final _height = window.physicalSize.height;
    return FlatButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return MyApp2(
              ur: link,
            );
            // WebDemo(ur: link);
          }));
        },
        child: Padding(
          padding: EdgeInsets.only(
            top: 26,
          ),
          child: Container(
              width: _width / 12,
              // child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                      child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32), bottom: Radius.circular(32)),
                    child: Image(
                      image: NetworkImage(
                          'https://img1.baidu.com/it/u=4194968875,3434087431&fm=26&fmt=auto&gp=0.jpg'),
                      fit: BoxFit.cover,
                    ),
                  )),
                  Text(
                    "${this.name}",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              )
              // )
              ),
        ));
  }
}
