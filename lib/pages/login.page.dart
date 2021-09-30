import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_project/widget/loginPage/first.dart';
import 'package:student_project/widget/loginPage/textLogin.dart';
import 'package:student_project/widget/loginPage/verticalText.dart';

import 'mainPage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  late User user ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.white, Colors.green]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(children: <Widget>[
                  VerticalText(),
                  TextLogin(),
                ]),
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextFormField(
                  controller: password,
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
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
                      try {
                        User? user =
                            (await _auth.signInWithEmailAndPassword(
                                email: email.text.trim(), password: password.text.trim())).user;
                        if (user !=null){
                          List<String> teacher = <String>[];
                          String name=  '';
                          int totalHome = 0;
                          Map<String,dynamic> teacherMap = Map<String,dynamic>();
                          var collection =
                          FirebaseFirestore.instance.collection('users');
                          var docSnapshot = await collection.doc(user.uid.toString()).get();
                          if (docSnapshot.exists) {
                            Map<String, dynamic>? data = docSnapshot.data();
                            if (data != null) {
                              name = data['name'];
                              totalHome = data['total'];
                              teacherMap = data as Map<String,dynamic>;
                              data.forEach((key1, value1) {
                                if (key1 != 'name' && key1 != 'total'&& key1 != 'uid') {
                                  teacher.add(key1);
                                }
                              });
                            }
                          }
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MainPage(name,user.uid,teacher,totalHome,teacherMap)));
                        }
                      } catch (e) {
                        print("Error catch");
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("failed"),
                        )
                        );
                      }
                      email.clear();password.clear();
                    },
                    padding: EdgeInsets.all(10.0),
                    color: Colors.white,
                    textColor: Color.fromRGBO(0, 160, 227, 1),
                    child: Text("Ok", style: TextStyle(fontSize: 15)),
                  ),
                ),
                FirstTime(),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
