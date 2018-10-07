import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final notesReference = FirebaseDatabase.instance.reference().child('notes');


class Summary extends StatelessWidget {
  final int score;
  final String name;
  final String number;
  final String age;
  final String level;
  Summary({Key key, this.score, this.name, this.number, this.age, this.level})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Final Score: $score",
                style: new TextStyle(fontSize: 35.0),
              ),
              new Padding(padding: EdgeInsets.all(30.0)),
              new MaterialButton(
                color: Colors.red,
                onPressed: () {
                  //questionNumber = 0;
                  //finalScore = 0;
                  //Navigator.pop(context);
                },
                child: new Text(
                  "Reset Quiz",
                  style: new TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}