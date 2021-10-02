import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/movie/movie_card/movies.dart';
import 'package:project2/movie/web_dteail.dart';
import 'package:project2/data/net/get_token.dart';
import 'package:project2/data/net/get_blog_data.dart';
import 'detail1.dart';
import 'package:cached_network_image/cached_network_image.dart';

List<Movie> scolist = [];

class Movie_Scroll extends StatelessWidget {
  Future get_data() async {
    scolist = await get_Blog_data("movie");
  }

  @override
  void initState() {
    initState();
    get_data();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: scolist.length,
          itemBuilder: (BuildContext context, int index) {
            return Item(item: scolist[index]);
          }),
    );
  }
}

class Item extends StatelessWidget {
  const Item({Key key, this.item}) : super(key: key);
  final Movie item;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 220.5,
        child: Card(
          color: Colors.white70,
          child: Column(
            children: [
              Container(
                width: 180,
                height: 250,
                padding: EdgeInsets.only(left: 5, top: 5),
                // decoration: BoxDecoration,
                child: InkWell(
                  child: CachedNetworkImage(
                    imageUrl: '${item.poster}',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext ctx) {
                      return new MovieDetail(
                        ur: item.onlyStr,
                        title: item.title,
                        type: item.cateId,
                      );
                    }));
                    print('${item.title}');
                  },
                ),
              ),
              Text('${item.title}'),
              Text(
                '${item.intro}',
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: TextStyle(color: Colors.grey, fontSize: 11),
              )
            ],
          ),
        ));
  }
}
