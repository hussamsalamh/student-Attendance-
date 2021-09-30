import 'package:flutter/material.dart';

class InputEmail extends StatefulWidget {
  String username = '';


  @override
  State<StatefulWidget> createState() {

    _InputEmailState hey = _InputEmailState();
    username = hey.username;
    return hey;
  }
}

class _InputEmailState extends State<InputEmail> {


  String username = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'Name',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
          onChanged:(text){
            username = text;
            print("the text $username");
          },
        ),
      ),
    );
  }

}
