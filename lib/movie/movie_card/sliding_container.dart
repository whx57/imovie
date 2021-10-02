import 'package:project2/movie/movie_card/movies.dart';
import 'package:flutter/material.dart';
import 'sliding_card.dart';

import 'package:project2/movie/movie_scroll.dart';

List<Movie> movies1 = scolist;

class SlidingContainer extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SlidingContainer> {
  PageController pageController;
  double pageoffset = 0;

  @override
  void initState() {
    pageController = PageController(viewportFraction: 0.95);
    pageController.addListener(() {
      setState(() => pageoffset = pageController.page);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      width: MediaQuery.of(context).size.width * 1,
      child: PageView(
          controller: pageController,
          children: List.generate(movies1.length, (index) {
            return SlidingCard(
              movie: movies1[index],
              offset: pageoffset - index,
            );
          })),
    );
  }
}
