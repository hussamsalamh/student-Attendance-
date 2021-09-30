// import 'package:flutter/material.dart';
// import 'package:student_project/students/StudentsInfo.dart';
//
// class StudentInfoButton extends StatefulWidget {
//   late StudentsInfo student;
//
//   StudentInfoButton(StudentsInfo s) {
//     student = s;
//   }
//
//   @override
//   _StudentInfoButton createState() => _StudentInfoButton(student);
// }
//
// class _StudentInfoButton extends State<StudentInfoButton> {
//   late StudentsInfo student;
//
//   _StudentInfoButton(StudentsInfo students) {
//     student = students;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: InkWell(
//             onTap: () {
//               setState(() {
//                 student.inClass = !student.inClass;
//                 student.inClass
//                     ? student.time.add(pair(DateTime.now(), DateTime.now()))
//                     : student.time[student.time.length - 1][1] = DateTime.now();
//                 if (student.inClass) {
//                   student.entryTimeClass = DateTime.now();
//                   student.entryTime += 1;
//                 }
//               });
//             },
//             child: Chip(
//               backgroundColor: student.inClass ? Colors.green : Colors.white54,
//               avatar: CircleAvatar(
//                 child: Icon(Icons.account_circle),
//               ),
//               label: Text(student.name),
//             )));
//   }
// }
