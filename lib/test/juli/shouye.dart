// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'test.dart';
// class moviescroll extends StatelessWidget {
//   // const moviescroll({Key? key}) : super(key: key);
//   final List imgList=[
//     'https://img2.doubanio.com/view/photo/m/public/p2637084112.webp',
//     'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2634360594.webp',
//     'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p725871968.webp',
//     'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2316834186.webp',
//     'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p1968975252.webp'
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//       Center(
//       child: Container(
//         height: 200,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//             itemBuilder: (BuildContext context,int i){
//               var item = imgList[i];
//               return _ImgeItem(url: item);
//             },
//           itemCount: imgList.length,
//         )
//       )
//     )
//     );
//
//   }
// }
// class _ImgeItem extends StatelessWidget {
//   const _ImgeItem({Key key, this.url}) : super(key: key);
//   final String url;
//   @override
//   Widget build(BuildContext context) {
//     return  GestureDetector(
//       onTap: (){
//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (BuildContext context){
//               return Detail();
//             })
//         );
//       },
//       child: Container(
//         width: 135,
//         child: Image(image: NetworkImage(
//             '$url'
//
//         ),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }
//
