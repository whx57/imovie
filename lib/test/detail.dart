// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:webview_flutter/webview_flutter.dart';
//
// class MovieDetail extends StatefulWidget {
//   MovieDetail({Key key,  this.ur,  this.title})
//       : super(key: key);
//
//   // final String id;
//   final String title;
//   final String ur;
//
//   @override
//   State<StatefulWidget> createState() {
//     return _MovieDetailState();
//   }
// }
//
// class _MovieDetailState extends State<MovieDetail>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;
//   var mlist;
//
//   void initState() {
//     getMovie();
//     super.initState();
//     // Enable hybrid composition.
//     if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//           centerTitle: true,
//         ),
//         body:
//             // Text("${widget.title}")
//             Column(
//           children: <Widget>[
//             // Image.network(mlist['imgUrl'],
//             //     width: 130, height: 180, fit: BoxFit.cover),
//           ],
//         )
//         // SafeArea(child:
//         //     WebView(
//         //       initialUrl:  widget.ur,
//         //     )
//         // )
//         // Text("电影id为${widget.id}"),
//
//         );
//     // return SafeArea(
//     //     child: WebView(
//     //       initialUrl: widget.ur,
//     //     ));
//   }
//
//   getMovie() async {
//     var response = await http.get(
//       Uri.parse(
//           // "http://api.vopipi.cn/api/index"
//           // "http://api.vopipi.cn/api/hot"
//           "http://api.vopipi.cn/api/info?type=1&onlyStr="
//           //   'http://api.vopipi.cn/api/list?type=1&rank=rankpoint&page=1'
//           ),
//       // "http://api.vopipi.cn/api/auth",
//       headers: {
//         "token":
//             "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpcCI6IjEyNS42NS43NC40MCIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzkyLjAuNDUxNS4xNTkgU2FmYXJpLzUzNy4zNiIsInRpbWUiOjYzNzY1ODQyNzI2NDg2NDUzMSwidGltZW91dCI6IjIwMjEtMDktMjhUMTQ6MDU6MjYuNDg2NDUzMSswODowMCJ9.Wd5KGSh4c2bBXLMyG-xOMHSrbLVra49R5mcN-GJsZgU"
//       },
//     );
//     // print(response.statusCode);
//     //
//     var result = response.body;
//     Map<String, dynamic> re2 = json.decode(result);
//     print("ok");
//     print(re2);
//     setState(() {
//       mlist = re2;
//     });
//   }
// }
