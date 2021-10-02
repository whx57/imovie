import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:url_launcher/url_launcher.dart';
class OpenWeb extends StatefulWidget {
  @override
  _OpenWebState createState() => _OpenWebState();
}

class _OpenWebState extends State<OpenWeb> {
  Brightness brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: brightness,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('如何实现夜间模式'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  setState(() {
                    if (brightness == Brightness.dark) {
                      brightness = Brightness.light;
                    } else {
                      brightness = Brightness.dark;
                    }
                  });
                },
                child: Text('切换模式'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
