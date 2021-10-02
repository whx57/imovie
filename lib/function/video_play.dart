import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyApp1 extends StatefulWidget {
  MyApp1({
    Key key,
    this.ur,
  }) : super(key: key);
  final String ur;

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp1> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

///////////////////////////
  @override
  BuildContext context;

  Future<bool> _requestPop() {
    Navigator.of(context).pop(100);

    ///弹出页面并传回int值100，用于上一个界面的回调
    return new Future.value(false);
  }

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
        // webViewController.setWebViewClient(new WebViewClient());
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return MaterialApp(
      home: Container(
          child: SafeArea(
              child: Column(children: <Widget>[
        Expanded(
          child: Stack(
            children: [
              WillPopScope(
                  child: new WebviewScaffold(
                    url: widget.ur,
                  ),
                  onWillPop: _requestPop),
            ],
          ),
        ),
      ]))),
    );
    ;
  }
}
