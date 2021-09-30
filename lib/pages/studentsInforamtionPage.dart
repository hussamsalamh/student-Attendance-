import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_project/students/StudentsInfo.dart';

class StudentInformationPage extends StatefulWidget {
  late StudentsInfo student;
  late DateTime start;
  late DateTime end;

  StudentInformationPage(StudentsInfo s, DateTime st, DateTime en) {
    student = s;
    start = st;
    end = en;
  }

  @override
  _S createState() => _S(student: student, startDate: start, endDate: end);
}

class _S extends State<StudentInformationPage> {
  late StudentsInfo student;
  late DateTime startDate;
  late DateTime endDate;

  _S({required this.student, required this.startDate, required this.endDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(student.name),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.green]),
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: generate(),
          ),
        ));
  }

  List<Widget> generate() {
    List<Widget> rows = <Widget>[];
    DateTime dateTime = DateTime.now();
    student.map.forEach((key, value) {
      String date = key.replaceAll('-','')+'T'+'000000';
      if(key != 'name' && key !='homework'){
      dateTime = DateTime.parse(date);
      }
      if (key != 'name' && key != 'homework'&&
          dateTime.difference(startDate).inDays >= 0 &&
      endDate.difference(dateTime).inDays >= 0) {
        rows.add(generateRow(
          student: student,
          date: key,
        ));
      }
    });
    return rows;
  }
}

class generateRow extends StatelessWidget {
  late StudentsInfo student;
  late String date;

  generateRow({required this.student, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 300.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Divider(
              thickness: 5,
            ),
            Text(date + "\n\n         "),
            Text("\n\nStudent attendance : " +
                "${(100 * student.map[date]['att']).toString()} %\n\n"
                    " Student behavior : ${student.map[date]['be']} \n\n"
                    "Number of Homework that day ${student.map[date]['didHomework'].toString()}  \n\n"
                    "Number of entry to class : ${student.map[date]['entryTime'].toString()}   \n\n"
                    "Time of entry class :\n\n ${student.map[date]['lst'].join(" , ")}"),
          ],
        ));
  }
}
