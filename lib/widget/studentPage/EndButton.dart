import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_project/students/StudentsInfo.dart';

//TODO : when press end class send the data to the firebase

class EndButton extends StatelessWidget {
  late List<StudentsInfo> lst = <StudentsInfo>[];
  late DateTime startTime;
  late DateTime endTime;
  late DateTime selectedDate;
  late DateTime startBreakTime;
  late DateTime endBreakTime;
  late String? id;
  bool flag = false;
  late int totalHomework;

  EndButton(List<StudentsInfo> s, DateTime t, DateTime d, String? i, int a,
      DateTime endBreak, DateTime startBreak) {
    selectedDate = t;
    lst = s;
    startTime = d;
    id = i;
    totalHomework = a;
    endBreakTime = endBreak;
    startBreakTime = startBreak;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton.icon(
        // color: Colors.white,
        label: Text(
          "End Class",
          style: TextStyle(fontSize: 13),
        ),

        onPressed: () {
          endTime = DateTime.now();
          endClass(context);
        },
        icon: Icon(Icons.ac_unit, size: 13, color: Colors.white),
      ),
    );
  }

  void calculatePercentage(StudentsInfo student) {
    for (var i = 0; i < student.time.length; i++) {
      student.totalTime +=
          student.time[i][1].difference(student.time[i][0]).inMinutes;
    }
    if (endTime.difference(startTime).inMinutes != 0 ) {
      student.per =
          (student.totalTime ) / (endTime.difference(startTime).inMinutes);
    }
    student.time.clear();
    student.inClass = false;
  }

  void endClass(BuildContext context) {
    for (var i = 0; i < lst.length; i++) {
      if (lst[i].inClass) {
        lst[i].time[lst[i].time.length - 1][1] = endTime;
      }
      calculatePercentage(lst[i]);
    }
    submitData(context);
    submitTeacher(context);
  }

  Future<void> submitData(BuildContext context) async {
    var be = {0: "Exellent", 1: 'Good', 2: 'bad'};
    var collection = FirebaseFirestore.instance.collection('students');
    var docSnapshot = await collection.doc(id).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      if (data != null) {
        var homework = 0;
        try {
          for (var i = 0; i < lst.length; i++) {
            homework = data[lst[i].idNumber.toString()]['homework'];
            print(lst[i].idNumber.toString());
            if (lst[i].didHomework != 0) {
              homework = homework + lst[i].didHomework;
            }
            data[lst[i].idNumber.toString()]['homework'] = homework;
            data[lst[i].idNumber.toString()]
                [DateFormat('yyyy-MM-dd').format(selectedDate)] = {
              'att': double.parse(lst[i].per.toStringAsFixed(2)),
              'be': be[lst[i].behavior.index],
              'didHomework': lst[i].didHomework,
              'entryTime': lst[i].timeEntryList.length,
              'lst': lst[i].timeEntryList
              // ];
            };
          }
        } catch (e) {
          print('wtf');
        }
        FirebaseFirestore.instance.collection('students').doc(id).update(data);
      }
    }
  }

  Future<void> submitTeacher(BuildContext context) async {
    var collection1 = FirebaseFirestore.instance.collection('users');
    var docSnapshot1 = await collection1.doc(id).get();
    if (docSnapshot1.exists) {
      Map<String, dynamic>? data1 = docSnapshot1.data();
      if (data1 != null) {
        try {
          int classTime = endTime.difference(startTime).inMinutes;
          var h = data1['total'];
          h += totalHomework;
          data1['total'] = h;
          data1[DateFormat('yyyy-MM-dd').format(selectedDate)] = {
            'classTime': classTime,
            'breakTime': classTime != 0
                ? double.parse(
                    (endBreakTime.difference(startBreakTime).inMinutes /
                            classTime)
                        .toStringAsFixed(2))
                : 0
          };
        } catch (e) {
          print('wtf');
        }
        FirebaseFirestore.instance.collection('users').doc(id).update(data1);
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }
  }
}
