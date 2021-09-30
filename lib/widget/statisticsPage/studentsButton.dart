import 'package:flutter/material.dart';
import 'package:student_project/pages/studentStatPage.dart';
import 'package:student_project/students/StudentsInfo.dart';

class StudentButton extends StatefulWidget {
  late StudentsInfo studentsInfo;
  late int total;
  late String date;
  late Map<String, dynamic> teacherMap = Map<String, dynamic>();

  StudentButton(StudentsInfo s, int t, String d, Map<String, dynamic> map) {
    studentsInfo = s;
    total = t;
    date = d;
    teacherMap = map;
  }

  _StudentButton createState() =>
      _StudentButton(studentsInfo, total, date, teacherMap);
}

class _StudentButton extends State<StudentButton> {
  late StudentsInfo student;
  late Map<String, dynamic> teacherMap = Map<String, dynamic>();
  late int total;
  late String date;

  _StudentButton(StudentsInfo s, int t, String d, Map<String, dynamic> map) {
    student = s;
    total = t;
    date = d;
    teacherMap = map;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: OutlineButton(
          color: Colors.white,
          onPressed: () {
            if (student.map.containsKey(date)) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          StudentsStatPage(student, total, date, teacherMap)));
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) => _buildPopupDialog(context),
              );
            }
          },
          child: Text(
            '\n' + student.name + '\n',
            style: TextStyle(),
          ),
          highlightColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ));
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(''),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'This student was absent in this day ',
              style: TextStyle(fontSize: 16),
            ),
            // icon: Icon(
            //   Icons.back,
            //   size: 13,
            // ),
          ),
        ],
      ),
    );
  }
}
