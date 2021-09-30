import 'package:flutter/material.dart';
import 'package:student_project/students/StudentsInfo.dart';
import 'package:fl_chart/fl_chart.dart';

class StudentsStatPage extends StatefulWidget {
  late StudentsInfo student;
  late int total;
  late Map<String,dynamic> teacherMap = Map<String , dynamic>();
  late String date;

  StudentsStatPage(StudentsInfo s, int t, String d,Map<String,dynamic>map) {
    student = s;
    total = t;
    teacherMap = map;
    date = d;
  }

  @override
  _Students createState() => _Students(student, total, date,teacherMap);
}

class _Students extends State<StudentsStatPage> {
  late StudentsInfo student;
  late int total;
  late Map<String,dynamic> teacherMap = Map<String , dynamic>();
  late String date;

  _Students(StudentsInfo s, int t, String d,Map<String,dynamic>map) {
    student = s;
    total = t;
    teacherMap = map;
    print(map);
    date = d;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(student.name),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.green]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(' '),
              Container(
                height: 200,
                child :PieChart(PieChartData(
                    borderData: FlBorderData(show:false),
                    sectionsSpace: 0,
                    sections: getSection())
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text(" red : Outside class\ngreen : Inside class \nwhite: Break"),
                  // Text("green : Inside class"),
                ]
              ),
              Text('Number of Homework ' + student.numberOfHomework.toString()+''
                  ' \n            from total ${total.toString()}'),
              Text("\nNumber of entry the class was ${student.map[date]['entryTime'].toString()}\n"),
              Text("\nThe behavior : ${student.map[date]['be']}")
            ],
          )),
        );
  }

  List<PieChartSectionData> getSection() {
    double per = 0;
    double breakTime = 0;
    if (student.map[date]['att'] != null && teacherMap[date]["breakTime"] != null) {
      per = student.map[date]['att'];
      breakTime = teacherMap[date]['breakTime'];
    }
    print(breakTime.toString());
    List<Data> data = [
      Data(name: "In class", per: 100 * per, Color: Colors.green),
      Data(name: "Outside class", per: 100 * (1 - per - breakTime), Color: Colors.red),
      Data(name:"Break time",per: 100 * (breakTime),Color:Colors.white)
    ];
    return data
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          final value = PieChartSectionData(
              color: data.Color,
              value: data.per,
              title: '${data.per.toStringAsFixed(1)}%',
              titleStyle: TextStyle(fontSize: 16));
          return MapEntry(index, value);
        })
        .values
        .toList();
  }
}

class Data {
  final String name;
  final double per;
  final Color;

  Data({required this.name, required this.per, required this.Color});
}



