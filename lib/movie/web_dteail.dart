import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as inweb;

class WebDemo extends StatefulWidget {
  WebDemo({
    Key key,
    this.ur,
  }) : super(key: key);
  final String ur;

  @override
  _WebDemoState createState() => _WebDemoState();
}

class _WebDemoState extends State<WebDemo> {
  @override
  BuildContext context;

  Future<bool> _requestPop() {
    Navigator.of(context).pop(100);

    ///弹出页面并传回int值100，用于上一个界面的回调
    return new Future.value(false);
  }

  void initState() {
    super.initState();

  }

  var _controller;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new WillPopScope(
        child: new WebviewScaffold(
          url: widget.ur,
        ),
        onWillPop: _requestPop);
  }
}
