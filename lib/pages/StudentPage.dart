import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_project/students/StudentsInfo.dart';
import 'package:student_project/widget/behavioral/studentSelect.dart';
import 'package:student_project/widget/studentPage/EndButton.dart';

class StudentPage extends StatefulWidget {
  late String? id;
  late List<StudentsInfo> lst = <StudentsInfo>[];
  late DateTime selectedDate;
  late DateTime startTime;
  late int home;
  late DateTime startBreak;
  late DateTime endBreak;
  StudentPage(List<StudentsInfo> s, DateTime t, DateTime start, String? i,int h,
      DateTime st,DateTime end) {
    lst = s;
    selectedDate = t;
    startTime = start;
    id = i;
    home = h;
    endBreak = end;startBreak = st;
  }

  @override
  _StudentPage createState() => _StudentPage(lst, selectedDate, startTime, id,home,
  startBreak,endBreak);
}

class _StudentPage extends State<StudentPage> {
  late String? id;
  late List<StudentsInfo> lst = <StudentsInfo>[];
  late List<Widget> buttons = <Widget>[];
  late DateTime selectedDate;
  late DateTime startTime;
  late int totalHomework ;
   late DateTime startBreak  ;
   late DateTime endBreak ;

  _StudentPage(List<StudentsInfo> s, DateTime t, DateTime start, String? i,int homeNumber,
      DateTime st,DateTime end) {
    lst = s;
    selectedDate = t;
    startTime = start;
    id = i;
    totalHomework = homeNumber;
    startBreak = st;endBreak = end;
  }

  @override
  Widget build(BuildContext context) {
    generateButton();
    return Scaffold(
        appBar: AppBar(title: Text("Student Page")),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.white, Colors.green]),
            ),
            child: ListView(children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      EndButton(
                          lst, selectedDate, startTime, id, totalHomework,endBreak,startBreak),
                      breakButton()
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => setState(() => totalHomework--),
                        ),
                        Text("  Homework  " + totalHomework.toString()),
                        IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => setState(() => totalHomework++)),
                      ]),
                  Text(""),
                  Divider(
                    thickness: 5,
                    height: 30,
                    color: Colors.white,
                  ),
                ],
              ),
              Column(
                children: buttons,
              )
            ])));
  }

  void generateButton() {
    buttons.clear();
    for (var i = 0; i < lst.length; i++) {
      ;
      buttons.add(StudentSelect(lst[i]));
    }
  }

  Widget breakButton() {
    return Container(
      child: FlatButton.icon(
        // color: Colors.white,
        label: Text(
          "break",
          style: TextStyle(fontSize: 13),
        ),

        onPressed: () {
          startBreak = DateTime.now();
          for (int i = 0; i < lst.length; i++) {
            if (lst[i].inClass) {
              lst[i]
                  .timeEntryList
                  .add(DateFormat('kk:mm:a').format(DateTime.now()));
              lst[i].time[lst[i].time.length - 1][1] = DateTime.now();

              lst[i].entryTimeClass =
                  DateFormat('kk:mm:a').format(DateTime.now());
              lst[i].inClass = false;
            }
          }
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context),
          );
        },
        icon: Icon(Icons.ac_unit, size: 13, color: Colors.white),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(''),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new TextButton(
            onPressed: () {
              endBreak = DateTime.now();
              Route route = MaterialPageRoute(builder: (context) =>
                  StudentPage(lst,selectedDate,startTime,id,totalHomework,
                      startBreak,endBreak));
              Navigator.pushReplacement(context, route);
            },
            child: const Text(
              'Resume ',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
