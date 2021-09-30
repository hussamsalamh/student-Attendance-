import 'package:flutter/material.dart';
import 'package:student_project/pages/studentsInforamtionPage.dart';
import 'package:student_project/students/StudentsInfo.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class StudentName extends StatefulWidget {
  late List<StudentsInfo> lst = <StudentsInfo>[];
  late DateTime end;
  late DateTime start;
  late int total;

  StudentName(List<StudentsInfo> s, int t, DateTime st, DateTime en) {
    lst = s;
    total = t;
    start = st;
    end = en;
  }

  @override
  _StudentName createState() => _StudentName(lst, total, start, end);
}

class _StudentName extends State<StudentName> {
  late List<StudentsInfo> lst = <StudentsInfo>[];
  late List<Widget> buttons = <Widget>[];
  late DateTime start;
  late DateTime end;
  late int total;

  _StudentName(List<StudentsInfo> s, int t, DateTime st, DateTime en) {
    lst = s;
    total = t;
    start = st;
    end = en;
  }

  @override
  Widget build(BuildContext context) {
    generateButtons();
    return Scaffold(
        appBar: AppBar(
          title: Text("Student Information"),
          centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Route route = MaterialPageRoute(
                        builder: (context) => StudentName(
                            lst, total,start,end));
                    Navigator.pushReplacement(context, route);
                  },
                  child: Icon(
                    Icons.refresh,
                    size: 26.0,
                  ),
                ),
              )
            ]
        ),
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
                // datePicker(context),
                Container(
                  child: SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.range,
                    onSelectionChanged: _onSelectionChanged,
                  ),
                ),
                Divider(
                  thickness: 5,
                  height: 30,
                  color: Colors.white,
                ),
                Column(children: buttons),
              ],
            )));
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs lst) {
    if(lst.value.startDate != null){
      start = lst.value.startDate;
    }if(lst.value.endDate !=null){
      end = lst.value.endDate;
    }
  }


  void generateButtons() {
    for (var i = 0; i < lst.length; i++) {
      buttons.add(InitButton(lst[i], total, start, end));
    }
  }
}

class InitButton extends StatefulWidget {
  late StudentsInfo studentsInfo;
  late DateTime start;
  late DateTime end;
  late int total;

  InitButton(StudentsInfo s, int t, DateTime st, DateTime en) {
    studentsInfo = s;
    total = t;
    start = st;
    end = en;
  }

  _InitButton createState() => _InitButton(studentsInfo, start, end);
}

class _InitButton extends State<InitButton> {
  late StudentsInfo student;
  late DateTime start;
  late DateTime end;

  _InitButton(StudentsInfo s, DateTime st, DateTime en) {
    student = s;
    start = st;
    end = en;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: OutlineButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        StudentInformationPage(student, start, end)));
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
}
