// import 'package:flutter/material.dart';
//
//
//
// class StartButton extends StatelessWidget{
//
//   late DateTime startTime;
//   bool flag = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: FlatButton.icon(
//         // color: Color.green,
//         label: Text(
//           "Start Class",
//           style: TextStyle(fontSize: 13),
//         ),
//
//         onPressed: () {
//           if(!flag){
//             startTime = DateTime.now();
//             flag = !flag;
//           }
//         },
//         icon: Icon(Icons.ac_unit,
//             size: 13, color: Colors.white),
//       ),
//     );
//   }
// }