import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_project/pages/removeStudent.dart';
import 'package:student_project/pages/statisticsPage.dart';
import 'package:student_project/pages/studentName.dart';
import 'package:student_project/students/StudentsInfo.dart';
import 'StudentPage.dart';
import 'addStudentPage.dart';

class MainPage extends StatefulWidget {
  late String name;
  late String? id;
  late List<String> teacher = <String>[];
  late int totalHome = 0;
  late Map<String, dynamic> teacherMap = Map<String, dynamic>();

  MainPage(String n, String? i, List<String> t, int total,
      Map<String, dynamic> map) {
    name = n;
    id = i;
    teacher = t;
    totalHome = total;
    teacherMap = map;
  }

  @override
  _MainPage createState() =>
      _MainPage(name, id, teacher, totalHome, teacherMap);
}

class _MainPage extends State<MainPage> {
  late String name;
  late String? id;
  int totalHome = 0;
  late List<String> teacher = <String>[];
  late Map<String, dynamic> teacherMap = Map<String, dynamic>();
  final List<StudentsInfo> lst = <StudentsInfo>[];
  String date = "";
  DateTime selectedDate = DateTime.now();

  _MainPage(
      String n, String? i, List<String> a, int t, Map<String, dynamic> map) {
    lst.clear();
    name = n;
    id = i;
    teacher = a;
    totalHome = t;
    teacherMap = map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          title: Text(name),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.greenAccent,
                    ),
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text(
                        "\nPick the date for class\n" +
                            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}\n",
                        style: TextStyle(fontSize: 15)),
                  ),
                )
              ]),
              Row(children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.greenAccent,
                    ),
                    onPressed: () async {
                      DateTime time = DateTime.now();
                      lst.clear();
                      var collection =
                          FirebaseFirestore.instance.collection('students');
                      var docSnapshot = await collection.doc(id).get();
                      if (docSnapshot.exists) {
                        Map<String, dynamic>? data = docSnapshot.data();
                        print(data);
                        if (data != null) {
                          data.forEach((key, value) {
                            if (data[key]['name'] == '') {
                            } else {
                              String name = data[key]['name'];
                              int id = int.parse(key);
                              value = value as Map<String, dynamic>;
                              int number = data[key]['homework'];
                              StudentsInfo student =
                                  StudentsInfo(name, id, number);
                              student.map = value;
                              lst.add(student);
                            }
                          });
                        }
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentPage(
                                  lst,
                                  selectedDate,
                                  time,
                                  id,
                                  0,
                                  DateTime.now(),
                                  DateTime.now())));
                    },
                    child: Text("\nStart the class\n",
                        style: TextStyle(fontSize: 15)),
                  ),
                )
              ]),
              Row(children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.greenAccent,
                    ),
                    onPressed: () async {
                      lst.clear();
                      var collection =
                          FirebaseFirestore.instance.collection('students');
                      var docSnapshot = await collection.doc(id).get();
                      if (docSnapshot.exists) {
                        Map<String, dynamic>? data = docSnapshot.data();
                        print(data);
                        if (data != null) {
                          data.forEach((key, value) {
                            if (data[key]['name'] == '') {
                            } else {
                              String name = data[key]['name'];
                              int id = int.parse(key);
                              value = value as Map<String, dynamic>;
                              int number = data[key]['homework'];
                              StudentsInfo student =
                                  StudentsInfo(name, id, number);
                              student.map = value;
                              lst.add(student);
                            }
                          });
                        }
                      }

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StatisticsPage(
                                  lst,
                                  totalHome,
                                  teacher,
                                  teacher.isNotEmpty ? teacher[0] : '',
                                  teacherMap)));
                    },
                    child:
                        Text("\nStatistics\n", style: TextStyle(fontSize: 15)),
                  ),
                )
              ]),
              Row(children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.greenAccent,
                    ),
                    onPressed: () async {
                      lst.clear();
                      var collection =
                          FirebaseFirestore.instance.collection('students');
                      var docSnapshot = await collection.doc(id).get();
                      if (docSnapshot.exists) {
                        Map<String, dynamic>? data = docSnapshot.data();
                        if (data != null) {
                          data.forEach((key, value) {
                            if (data[key]['name'] == '') {
                            } else {
                              String name = data[key]['name'];
                              int id = int.parse(key);
                              value = value as Map<String, dynamic>;
                              int number = data[key]['homework'];
                              StudentsInfo student =
                                  StudentsInfo(name, id, number);
                              student.map = value;
                              lst.add(student);
                            }
                          });
                        }
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentName(lst, totalHome,
                                  DateTime.now(), DateTime.now())));
                    },
                    child: Text("\nStudents Information\n",
                        style: TextStyle(fontSize: 15)),
                  ),
                )
              ]),
              Row(children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.greenAccent,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddStudent(id)));
                    },
                    child: Text("\n Add Students \n",
                        style: TextStyle(fontSize: 15)),
                  ),
                )
              ]),
              Row(children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.greenAccent,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => removeStudent(id)));
                    },
                    child: Text("\n Remove Students \n",
                        style: TextStyle(fontSize: 15)),
                  ),
                )
              ]),
            ],
          ),
        ));
  }

  void printLst() {
    for (var i = 0; i < lst.length; i++) {
      print(lst[0].name);
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }
}
