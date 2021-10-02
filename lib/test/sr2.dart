// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:project2/movie/detail1.dart';
// import 'package:http/http.dart' as http;
// import 'package:project2/data/net/get_token.dart';
// import 'package:project2/data/net/get_blog_data.dart';
// Dio dio = new Dio();
//
// // void main()=>runApp(Myapp());
//
// // class Myapp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         body: Container(
// //           child: MyFullWidget(),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// class MovieList1 extends StatefulWidget {
//   MovieList1({Key key,  this.mt}) : super(key: key);
//
//   final String mt;
//
//   @override
//   State<StatefulWidget> createState() {
//     return new _MovieListState();
//   }
// }
//
// class _MovieListState extends State<MovieList1> {
//   var mlist = [];
//   var total = 0;
//
//   @override
//   var _futureBuilderFuture;/////////////////
//   Future _gerData() async {//////////////
//     String token = await get_Token();
//     var response = await http.get(
//       Uri.parse("http://api.vopipi.cn/api/search?wd=${widget.mt}"),
//       headers: {"token": token},
//     );
//     return response.body;
//   }
//
//   void initState() {
//     _futureBuilderFuture = _gerData();//////////////////
//     super.initState();
//   }
//
//   Widget build(BuildContext context) {
//     return
//       Container(
//         child:
//         RefreshIndicator(///////////////
//           onRefresh: _gerData,
//           child: FutureBuilder(
//             builder: _buildFuture,
//             future: _futureBuilderFuture,
//           ),
//         ),
//       );
//
//   }
//
//   Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {///////////////
//     switch (snapshot.connectionState) {
//       case ConnectionState.none:
//         print('还没有开始网络请求');
//         return Text('还没有开始网络请求');
//       case ConnectionState.active:
//         print('active');
//         return Text('ConnectionState.active');
//       case ConnectionState.waiting:
//         print('waiting');
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       case ConnectionState.done:
//         print('done');
//         if (snapshot.hasError) return Text('Error: ${snapshot.error}');
//         return _createListView(context, snapshot); //////////////
//       default:
//         return Text('还没有开始网络请求');
//     }
//   }
//
//   Widget _createListView(BuildContext context, AsyncSnapshot snapshot){////////////////
//     var mlist1 = snapshot.data;
//     Map<String, dynamic> re2 = json.decode(mlist1);
//     mlist = re2['data'];
//     return     ListView.builder(
//       itemBuilder: (BuildContext ctx, int i) {
//         var mitem = mlist[i];
//         return GestureDetector(
//           onTap: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (BuildContext ctx) {
//                   return new MovieDetail(
//                     ur: mitem['onlyStr'],
//                     title: mitem['title'],
//                     type: mitem['cateId'],
//                   );
//                 }));
//           },
//           child: Container(
//               height: 200,
//               decoration: BoxDecoration(
//                   color: Colors.white10,
//                   border: Border(top: BorderSide(color: Colors.black12))),
//               child: Row(
//                 children: <Widget>[
//                   Image.network(mitem['imgUrl'],
//                       width: 130, height: 180, fit: BoxFit.cover),
//                   Container(
//                     padding: EdgeInsets.only(left: 10),
//                     height: 150,
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: <Widget>[
//                           Text('电影名称: ${mitem['title']}'),
//                           Text('上映时间: ${mitem['years']}年'),
//                           Text('评分: ${mitem['score']}'),
//                         ]),
//                   )
//                 ],
//               )),
//         );
//       },
//       itemCount: mlist.length,
//     );
//   }
// }
