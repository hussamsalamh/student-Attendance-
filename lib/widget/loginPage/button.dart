import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:student_project/auth_services/AuthService.dart';
// import 'package:student_project/pages/mainPage.dart';
import 'package:student_project/students/StudentsInfo.dart';
// import 'package:provider/provider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ButtonLogin extends StatefulWidget {
  late String email = '';
  late String password = '';
  List<StudentsInfo> lst = <StudentsInfo>[];

  ButtonLogin(String e, String p) {
    print(e+"   username");
    print(p+ " pass");
    if (e.isEmpty || p.isEmpty) {
      return;
    }
  }

  @override
  State<StatefulWidget> createState() {
    return _ButtonLoginState(email, password);
  }
}

class _ButtonLoginState extends State<ButtonLogin> {
  late String email;
  late String password;
  late User user;

  List<StudentsInfo> lst = <StudentsInfo>[];

  _ButtonLoginState(String email, String password) {
    this.email = email;
    this.password = password;
  }

  void initState() {
    _auth.userChanges().listen((event) => setState(() => user = event!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 50.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          try {
            print(email + "  username");
            print(password + "  password");
            UserCredential user = (await _auth.
            signInWithEmailAndPassword(email: email, password: password));
            print(user.user?.uid.toString());
            print(user.user?.uid.toString());
          }catch (e){
            Scaffold.of(context).showSnackBar(
              const SnackBar(
                content: Text("failed"),
              )
            );
          }
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => MainPage("Mohand")));
        },
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        textColor: Color.fromRGBO(0, 160, 227, 1),
        child: Text("Ok", style: TextStyle(fontSize: 15)),
      ),
    );
  }

}
