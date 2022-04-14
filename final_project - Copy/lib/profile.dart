import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'stats.dart';

class profile extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<profile> {
  @override

  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)?.settings.arguments as character;
    if (args.team1name == null || args.team1score == null){
      args.team1name = '';
      args.team1score = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.orangeAccent,
      ),

      body: Center(
        child: ListView(
          children: [
            Container(
              child: Image.asset('assets/login.png'),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text('Username:', style: TextStyle(color: Colors.white),),
                ),
                Container(
                ),
              ],
            ),
            Container(
              child: RaisedButton(
                child: Text('Retrieve Profile 1'),
                onPressed: (){

                },
              ),
            ),

          ],
        ),
      ),
      backgroundColor: Colors.black54,
    );
  }
}