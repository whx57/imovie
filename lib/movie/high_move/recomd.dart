import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'package:project2/movie/list.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

class _TabData {
  final Widget tab;
  final Widget body;

  _TabData({this.tab, this.body});
}

final _tabDataList = <_TabData>[
  _TabData(tab: Text('top250'), body: new MovieList(mt: 'rankpoint')),
  _TabData(tab: Text('热门'), body: new MovieList(mt: 'rankhot')),
  _TabData(tab: Text('近期热门'), body: new MovieList(mt: 'createtime')),
];

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with AutomaticKeepAliveClientMixin
{
  final tabBarList = _tabDataList.map((item) => item.tab).toList();
  final tabBarViewList = _tabDataList.map((item) => item.body).toList();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabBarList.length,
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                color: Colors.blue,
                child: TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.blue,
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.white,
                    unselectedLabelStyle: TextStyle(
                      fontSize: 18,
                    ),
                    labelColor: Colors.red,
                    labelStyle: TextStyle(fontSize: 20),
                    tabs: tabBarList),
              ),
            ),
            Expanded(
                child: TabBarView(
              children: tabBarViewList,
              // physics: NeverScrollableScrollPhysics(), // 禁止滑动
            )),
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
