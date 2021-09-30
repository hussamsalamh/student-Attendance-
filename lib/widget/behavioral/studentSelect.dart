import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_project/pages/StudentPage.dart';
import 'package:student_project/students/StudentsInfo.dart';

@immutable
class StudentSelect extends StatefulWidget {
  late StudentsInfo student;

  StudentSelect(StudentsInfo s) {
    student = s;
  }

  _StudentSelect createState() => _StudentSelect(student);
}

class _StudentSelect extends State<StudentSelect> {
  late StudentsInfo student;

  _StudentSelect(StudentsInfo s) {
    student = s;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("   "),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        student.inClass = !student.inClass;
                        if (student.inClass) {
                          student.timeEntryList.add(
                              DateFormat('kk:mm:a').format(DateTime.now()));
                          student.time
                              .add(pair(DateTime.now(), DateTime.now()));
                          student.entryTimeClass =
                              DateFormat('kk:mm:a').format(DateTime.now());
                        } else {
                          student.time[student.time.length - 1][1] =
                              DateTime.now();
                        }
                      });
                    },
                    child: Chip(
                      backgroundColor:
                          student.inClass ? Colors.green : Colors.white54,
                      avatar: CircleAvatar(
                        child: Icon(Icons.account_circle),
                      ),
                      label: Text( student.name + '\n'),
                    ))),
            Text("  Time : " + student.entryTimeClass.toString() + "   -",
                style: TextStyle(fontSize: 16)),
            Text(
                "   How many entries :" +
                    student.timeEntryList.length.toString(),
                style: TextStyle(fontSize: 16)),
            Radio(
                value: Behavior.Excellent,
                groupValue: student.behavior,
                onChanged: (val) {
                  setState(() {
                    student.behavior = Behavior.Excellent;
                  });
                }),
            Text("E"),
            Radio(
                value: Behavior.Good,
                groupValue: student.behavior,
                onChanged: (val) {
                  setState(() {
                    student.behavior = Behavior.Good;
                  });
                }),
            Text("G"),
            Radio(
                value: Behavior.Bad,
                groupValue: student.behavior,
                onChanged: (val) {
                  setState(() {
                    student.behavior = Behavior.Bad;
                  });
                }),
            Text("B"),
            Text("     "),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => setState(() => student.didHomework--),
            ),
            Text("  Homework  " + student.didHomework.toString()),
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () => setState(() => student.didHomework++)),
            Text(""),
          ],
        ));
  }
}
