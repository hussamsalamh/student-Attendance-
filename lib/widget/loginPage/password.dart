import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  String password = '';
  @override
  State<StatefulWidget> createState() {
    _PasswordInputState inputState = _PasswordInputState();
    password = inputState.password;
    return inputState;
  }

}

class _PasswordInputState extends State<PasswordInput> {
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          onChanged: (text){
            password = text;
            print(password);
          },
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Password',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}