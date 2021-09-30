import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class removeStudent extends StatefulWidget {
  late String? id;

  removeStudent(String? i) {
    id = i;
  }

  @override
  _removeStudent createState() {
    return _removeStudent(id);
  }
}

class _removeStudent extends State<removeStudent> {
  late String? id;
  final TextEditingController idNumber = TextEditingController();

  // final database = FirebaseDatabase.instance.reference();

  _removeStudent(String? i) {
    id = i;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent,
          title: Text("Remove student"),
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
                      FirebaseFirestore.instance
                          .collection('students')
                          .doc(id)
                          .update({idNumber.text.trim(): FieldValue.delete()});
                      idNumber.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("success")));
                    },
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
