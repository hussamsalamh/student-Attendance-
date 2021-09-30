import 'package:flutter/material.dart';
import 'package:student_project/students/StudentsInfo.dart';
import 'package:student_project/widget/statisticsPage/studentsButton.dart';

class StatisticsPage extends StatefulWidget {
  late List<StudentsInfo> lst = <StudentsInfo>[];
  late List<String> teacher = <String>[];
  late Map<String, dynamic> teacherMap = Map<String, dynamic>();
  late int total;
  late String date;

  StatisticsPage(List<StudentsInfo> s, int t, List<String> d, String date1,
      Map<String, dynamic> map) {
    lst = s;
    total = t;
    teacher = d;
    date = date1;
    teacherMap = map;
  }

  @override
  _StatisticsPage createState() =>
      _StatisticsPage(lst, total, teacher, date, teacherMap);
}

class _StatisticsPage extends State<StatisticsPage> {
  late List<StudentsInfo> lst = <StudentsInfo>[];
  late List<Widget> buttons = <Widget>[];
  late List<String> teacher = <String>[];
  late Map<String, dynamic> teacherMap = Map<String, dynamic>();
  late int total;
  late String selectedDay;

  _StatisticsPage(List<StudentsInfo> s, int t, List<String> d, String da,
      Map<String, dynamic> map) {
    lst = s;
    total = t;
    teacher = d;
    selectedDay = da;
    teacherMap = map;
  }

  @override
  Widget build(BuildContext context) {
    generateButtons();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.lightGreen,
            title: Text("Statistics for students"),
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Route route = MaterialPageRoute(
                        builder: (context) => StatisticsPage(
                            lst, total, teacher, selectedDay, teacherMap));
                    Navigator.pushReplacement(context, route);
                  },
                  child: Icon(
                    Icons.refresh,
                    size: 26.0,
                  ),
                ),
              )
            ]),
        body: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.white, Colors.green]),
            ),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Text("Select day "), selectDate()],
                ),
                Divider(
                  thickness: 5,
                  height: 30,
                  color: Colors.white,
                ),
                Column(
                  children: buttons,
                )
              ],
            )));
  }

  Widget selectDate() {
    return Container(
        child: DropdownButton<String>(
      value: selectedDay,
      icon: Icon(Icons.keyboard_arrow_down),
      items: teacher.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newVal) {
        buttons.clear();
        setState(() {
          selectedDay = newVal!;
        });
      },
    ));
  }

  void generateButtons() {
    for (var i = 0; i < lst.length; i++) {
      buttons.add(StudentButton(lst[i], total, selectedDay, teacherMap));
    }
  }
}
