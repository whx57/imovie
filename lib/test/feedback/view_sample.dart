// import 'package:flutter/material.dart';
// import 'ServiceLocator.dart';
// import 'TelAndSmsService.dart';
//
// class   ViewSample extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       title: 'view add or remove',
//       theme: ThemeData(
//         primaryColor: Colors.green,
//       ),
//       home: ViewPage(),
//     );
//   }
// }
//
// class ViewPage extends StatefulWidget{
//   @override
//   ViewPageState createState() => ViewPageState();
//
// }
// class ViewPageState extends State<ViewPage>{
//   bool toggle = true;
//   final TelAndSmsService _service = locator<TelAndSmsService>();
//   final String number = "123456789";
//   final String email = "12345@example.com";
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('view page'),
//       ),
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             RaisedButton(
//               child: Text("打电话"),
//               onPressed: ()=> _service.call(number)
//               ,
//             ),
//             RaisedButton(
//                 child: Text("发短信"),
//                 onPressed: ()=> _service.sendSms(number)
//             ),
//             RaisedButton(
//                 child: Text("发邮件"),
//                 onPressed: ()=> _service.sendEmail(email)
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
// }
//
