import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_project/widget/loginPage/singup.dart';
import 'package:student_project/widget/loginPage/textNew.dart';
import 'package:student_project/widget/loginPage/userOld.dart';
import 'package:student_project/pages/login.page.dart';

import 'mainPage.dart';

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _NewUserState extends State<NewUser> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  // CollectionReference users = FirebaseFirestore.instance.collection('users');

  // late User user ;

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
                Row(
                  children: <Widget>[
                    SingUp(),
                    TextNew(),
                  ],
                ),
                TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                ),
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
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
                      addUser();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    padding: EdgeInsets.all(10.0),
                    color: Colors.white,
                    textColor: Color.fromRGBO(0, 160, 227, 1),
                    child: Text("Ok", style: TextStyle(fontSize: 15)),
                  ),
                ),
                UserOld(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addUser() async {
    try {
      print(name.text + " inside function");
      _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((value) async {
        User? user = _auth.currentUser;
        if (user != null) {
          print(user.uid + " this user id");
        } else {
          print("user is null");
        }
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user?.uid)
            .set({
          'uid': user?.uid.toString(),
          'name': name.text,
          'total' :0,
        });
        name.clear();
        email.clear();
        password.clear();
        await FirebaseFirestore.instance
            .collection("students")
            .doc(user?.uid)
            .set({});
      });
    } catch (e) {
      print("Catch");
    }
  }
}
