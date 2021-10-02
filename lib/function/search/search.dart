import 'dart:convert';

// import 'dart:html';
import 'package:project2/movie/web_dteail.dart';
import 'search_result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project2/data/net/get_token.dart';
import 'package:project2/data/net/get_blog_data.dart';
import 'package:project2/movie/douban.dart';
import '../../test/sr2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project2/main.dart';
import 'package:project2/movie/shouye.dart';
import 'package:project2/movie/douban.dart';
import 'history/search_history.dart';
import 'history/user_db_provider.dart';

typedef SearchItemCall = void Function(String item);

List<String> items2 = [];
List<SearchHistory> historyList = [];

void addToHistory(value) {
  var v = SearchHistory();
  v.name = value;
  v.time = DateTime.now().millisecondsSinceEpoch.toString();
  v.id = DateTime.now().millisecondsSinceEpoch;
  // setState(() {
  historyList.add(v);
  for (int i = 0; i < historyList.length; i++) {
    if (!(items2.contains(historyList[i].name)))
      items2.add(historyList[i].name);
  }
  showHistory(historyList);
  // });
}

//展示历史记录
void showHistory(list) {
  print(list);
}

class SearchBarDelegate extends SearchDelegate<String>

{
  @override
  List<Widget> buildActions(BuildContext context) {
    //右侧显示内容 这里放清除按钮
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //左侧显示内容 这里放了返回按钮
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        if (query.isEmpty) {
          close(context, 'null');
        } else {
          close(context, 'null');
          // query = "123";
          showSuggestions(context);
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //点击了搜索显示的页面

    if (!items2.contains(query)) {
      addToHistory(query);
    }
    return Center(
      child: MovieList(mt: query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //点击了搜索窗显示的页面
    return SearchContentView();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.grey,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.black),
      primaryColorBrightness: Brightness.dark,
      primaryTextTheme: theme.textTheme,
    );
  }

  Future<String> get1() async {
    var lisy_history;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lisy_history = await prefs.getString("12345");
    return lisy_history;
  }
}

class SearchContentView extends StatefulWidget {
  @override
  _SearchContentViewState createState() => _SearchContentViewState();
}

class _SearchContentViewState extends State<SearchContentView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              '大家都在搜',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SearchItemView(),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              '历史记录',
              style: TextStyle(fontSize: 16),
            ),
          ),
          // SearchItemView(),
          Container(
            child: InkWell(
              onTap: () {},
              child: Wrap(
                children: [for (String item in items2) TagItem(item)],
              ),
            ),
          )

          // SearchItemView()
        ],
      ),
    );
  }
}

class TagItem extends StatelessWidget {
  final String text;

  TagItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) {
          return buildResults(context);
        }));
        // buildResults(context);
      },
      child: Chip(
        label: Text(this.text),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ));
  }

  Widget buildResults(BuildContext context) {
    //点击了搜索显示的页面

    return Scaffold(
      appBar: AppBar(
        title: Text('搜索结果'),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Center(
        child: GestureDetector(child: MovieList(mt: text)),
      ),
    );
  }
}

class SearchItemView extends StatefulWidget {
  @override
  _SearchItemViewState createState() => _SearchItemViewState();
}

class _SearchItemViewState extends State<SearchItemView> {
  var mlist;

  SearchHistoryProvider provider = SearchHistoryProvider();

  // List<SearchHistoryWidget> widgetList = [];
  void initState() {
    super.initState();
    getMovie();
    // 读取本地存储的历史记录 并显示
    Future<List<SearchHistory>> listHistoryFuture = provider.getAllUser();
    listHistoryFuture.then((value) {
      setState(() {
        historyList = value;
        for (int i = 0; i < historyList.length; i++) {
          // print(list[i].name);
          if (!(items2.contains(historyList[i].name)))
            items2.add(historyList[i].name);
        }
        // showHistory(value);
      });
    });
  }

  void _saveHistory() async {
    provider.deleteAll();
    historyList.forEach((element) async {
      await provider.insertUser(element);
    });
  }

  @override
  void dispose() {
    _saveHistory();
    super.dispose();
  }

  var items = [];

  getMovie() async {
    String token = await get_Token();
    var response = await http.get(
      Uri.parse("http://api.vopipi.cn/api/hot"),
      headers: {"token": token},
    );
    var result = response.body;
    Map<String, dynamic> re2 = json.decode(result);

    setState(() {
      items = re2['data'];
    });
  }

  List<String> items1 = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        spacing: 10,
        // runSpacing: 0,
        children: items.map((item) {
          return SearchItem(
            title: item,
          );
        }).toList(),
      ),
    );
  }
}

class SearchItem extends StatefulWidget {
  @required
  final String title;

  const SearchItem({Key key, this.title}) : super(key: key);

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Chip(
          label: Text(widget.title),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onTap: () {
          if (!items2.contains(widget.title)) {
            // items2.add(widget.title);
            addToHistory(widget.title);
          }

          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext ctx) {
            return buildResults(context);
          }));
        },
      ),
      color: Colors.white,
    );
  }

  Widget buildResults(BuildContext context) {
    //点击了搜索显示的页面

    return Scaffold(
      appBar: AppBar(
        title: Text('搜索结果'),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Center(
        child: GestureDetector(child: MovieList(mt: widget.title)),
      ),
    );
  }
}
