import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/movie/movie_card/movies.dart';

import 'package:project2/movie/detail1.dart';

class SlidingCard extends StatelessWidget {
  final double offset;

  final Movie movie;

  SlidingCard({Key key, this.movie, this.offset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow(offset.abs() - 0.5, 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        margin: EdgeInsets.only(left: 4, right: 4, bottom: 10),
        elevation: 25,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(32),
              ),
              child: Image(
                image: NetworkImage(
                  '${movie.poster}',
                ),
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment(-offset.abs(), 0),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${movie.name}',
                    style: TextStyle(color: Colors.black, fontSize: 32),
                  ),
                  Text(
                    '${movie.intro}',
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext ctx) {
                            return new MovieDetail(
                              ur: movie.onlyStr,
                              title: movie.title,
                              type: movie.cateId,
                            );
                          }));
                        },
                        color: Colors.blue,
                        child: Text(
                          "more",
                          style: TextStyle(fontSize: 20),
                        ),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                      ),
                      Spacer(),
                      Text(
                        '${movie.date}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        width: 32,
                      )
                    ],
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
