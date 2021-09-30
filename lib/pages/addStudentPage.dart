import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  // NewClass(List<StudentsInfo>s){lst = s;}
  late String? id;

  AddStudent(String? i) {
    id = i;
  }

  @override
  _AddStudent createState() {
    return _AddStudent(id);
  }
}

class _AddStudent extends State<AddStudent> {
  late String? id;
  final TextEditingController name = TextEditingController();
  final TextEditingController idNumber = TextEditingController();
  // final database = FirebaseDatabase.instance.reference();

  _AddStudent(String? i) {
    id = i;
  }

  @override
  Widget build(BuildContext context) {
    // final students = database.child()
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent,
          title: Text("Add Student"),
        ),
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.green]),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                ),
                TextFormField(
                  controller: idNumber,
                  decoration: const InputDecoration(
                    labelText: "id Number",
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side:
                            BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                    onPressed: () async {
                      print(id);
                      print(idNumber.text);
                      print(name.text);
                      FirebaseFirestore.instance
                          .collection('students')
                          .doc(id)
                          .update({
                           idNumber.text: {
                          'name': name.text,
                          'homework': 0
                        }
                      });
                      name.clear();idNumber.clear();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("success")));
                    }

                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => MainPage(name.text)));

                    ,
                    padding: EdgeInsets.all(10.0),
                    color: Colors.white,
                    textColor: Color.fromRGBO(0, 160, 227, 1),
                    child: Text("Ok", style: TextStyle(fontSize: 15)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
