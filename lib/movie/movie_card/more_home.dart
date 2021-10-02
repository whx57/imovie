import 'package:flutter/material.dart';
import 'sliding_container.dart';

class mote_home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "今日推荐",
                style: TextStyle(
                    fontSize: 34,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SlidingContainer()
          ],
        ),
      ),
    );
  }
}
