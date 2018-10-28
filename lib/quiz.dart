//import 'dart:io' show Platform;
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'myData.dart';
import 'submitData.dart';
//import 'package:firebase_database/ui/firebase_animated_list.dart';

var finalScore = 0;
var questionNumber = 0;

/*final FirebaseApp app = FirebaseApp.configure(
  options: Platform.isIOS
      ? const FirebaseOptions(
          googleAppID: '1:297855924061:ios:c6de2b69b03a5be8',
          gcmSenderID: '297855924061',
          databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
        )
      : const FirebaseOptions(
          googleAppID: '1:297855924061:android:669871c998cc21bd',
          apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
          databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
        ),
);*/

class FirebaseTodos {
  static Future<MyData> getTodo(String todoKey) async {
    Completer<MyData> completer = new Completer<MyData>();

    FirebaseDatabase.instance
        .reference()
        .child("Quiz")
        .child(todoKey)
        //.child(todoKey)
        .once()
        .then((DataSnapshot snapshot) {
      completer.complete(new MyData.fromSnapshot(snapshot));
    });

    return completer.future;
  }
}

final notesReference = FirebaseDatabase.instance.reference().child('result');

class Quiz1 extends StatefulWidget {
  final String name, number, age, level;

  Quiz1(
      {Key key,
      @required this.name,
      @required this.number,
      @required this.age,
      @required this.level})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return QuizState1();
  }
}

class QuizState1 extends State<Quiz1> {
  //final DatabaseReference databaseReference =
  //   FirebaseDatabase.instance.reference().child("test");

  int _radioValue = -1;
  String question = "";
  String choice1 = "";
  String choice2 = "";
  String choice3 = "";
  String choice4 = "";
  String answer = "";

  @override
  void initState() {
    // TODO: implement initState
    FirebaseTodos.getTodo(questionNumber.toString()).then(_updateTodo);
    super.initState();
  }

  _updateTodo(MyData value) {
    debugPrint(value.toString());
    setState(() {
      question = value.question;
      choice1 = value.choice1;
      choice2 = value.choice2;
      choice3 = value.choice3;
      choice4 = value.choice4;
      answer = value.answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: new SingleChildScrollView(
            child: new Container(
              margin: const EdgeInsets.all(10.0),
              alignment: Alignment.topCenter,
              child: new Column(
                children: <Widget>[
                  new Padding(padding: EdgeInsets.all(20.0)),

                  new Container(
                    alignment: Alignment.centerRight,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          "Question ${questionNumber + 1} of ${4}",
                          style: new TextStyle(fontSize: 22.0),
                        ),
                        //new Text("Score: $finalScore",style: new TextStyle(fontSize: 22.0),)
                      ],
                    ),
                  ),

                  //image
                  //new Padding(padding: EdgeInsets.all(10.0)),

                  //new Image.asset(
                  //  "assets/${quiz.images[questionNumber]}.jpg",
                  // ),

                  new Padding(padding: EdgeInsets.all(10.0)),

                  new Text(
                    question,
                    style: new TextStyle(
                      fontSize: 20.0,
                    ),
                  ),

                  new Padding(padding: EdgeInsets.all(10.0)),

                  //radio button 1
                  new Row(
                    children: <Widget>[
                      new Radio(
                        value: 0,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      new Text(
                        choice1,
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                    ],
                  ),

                  //radio button 2
                  new Row(
                    children: <Widget>[
                      new Radio(
                        value: 1,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      new Text(
                        choice2,
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                    ],
                  ),

                  //radio button 3
                  new Row(
                    children: <Widget>[
                      new Radio(
                        value: 2,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      new Text(
                        choice3,
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                    ],
                  ),

                  //radio button 4
                  new Row(
                    children: <Widget>[
                      new Radio(
                        value: 3,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      new Text(
                        choice4,
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                    ],
                  ),

                  //button 4
                  /*new MaterialButton(
                  minWidth: 120.0,
                  color: Colors.blueGrey,
                  onPressed: () {
                    if (quiz.choices[questionNumber][3] ==
                        quiz.correctAnswers[questionNumber]) {
                      debugPrint("Correct");
                      finalScore++;
                    } else {
                      debugPrint("Wrong");
                    }
                    updateQuestion();
                  },
                  child: new Text(
                    quiz.choices[questionNumber][3],
                    style: new TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
                */
                  new Padding(padding: EdgeInsets.all(5.0)),
                  new ButtonBar(
                    children: <Widget>[
                      new MaterialButton(
                          minWidth: 150.0,
                          height: 30.0,
                          color: Colors.red,
                          onPressed: resetQuiz,
                          child: new Text(
                            "Quit",
                            style: new TextStyle(
                                fontSize: 18.0, color: Colors.white),
                          )),
                      new MaterialButton(
                          minWidth: 150.0,
                          height: 30.0,
                          color: Colors.blue,
                          onPressed: nextQuestion,
                          child: new Text(
                            "Next",
                            style: new TextStyle(
                                fontSize: 18.0, color: Colors.white),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      /*switch (_radioValue) {
        case 0:
          if (quiz.choices[questionNumber][0] ==
              quiz.correctAnswers[questionNumber]) {
            debugPrint("Correct");
            //finalScore++;
          } else {
            //finalScore--;
            debugPrint("Wrong");
          }
          break;
        case 1:
          if (quiz.choices[questionNumber][1] ==
              quiz.correctAnswers[questionNumber]) {
            debugPrint("Correct");
            //finalScore++;
          } else {
            //finalScore--;
            debugPrint("Wrong");
          }
          break;
        case 2:
          if (quiz.choices[questionNumber][2] ==
              quiz.correctAnswers[questionNumber]) {
            debugPrint("Correct");
            //finalScore++;
          } else {
            //finalScore--;
            debugPrint("Wrong");
          }
          break;
        case 3:
          if (quiz.choices[questionNumber][3] ==
              quiz.correctAnswers[questionNumber]) {
            debugPrint("Correct");
            //finalScore++;
          } else {
            //finalScore--;
            debugPrint("Wrong");
          }
          break;
      }*/
    });
  }

  void resetQuiz() {
    setState(() {
      Navigator.pop(context);
      finalScore = 0;
      questionNumber = 0;
      FirebaseTodos.getTodo(questionNumber.toString()).then(_updateTodo);
    });
  }

  void nextQuestion() {
    setState(() {
      if (_radioValue != -1) {
        if (_radioValue == 0) {
          if (choice1 == answer) {
            finalScore++;
          }
        } else if (_radioValue == 1) {
          if (choice2 == answer) {
            finalScore++;
          }
        } else if (_radioValue == 2) {
          if (choice3 == answer) {
            finalScore++;
          }
        } else if (_radioValue == 3) {
          if (choice4 == answer) {
            finalScore++;
          }
        }
        _radioValue = -1;
        updateQuestion();
      } else {
        _showDialog("Choose any one option", true);
      }
    });
  }

  void _showDialog(String message, bool flag) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(message),
          //content: new Text("Choose any one option"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                if (flag) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void updateQuestion() {
    setState(() {
      if (questionNumber == 3) {
        notesReference
            .push()
            .set(new SubmitData(new DateTime.now(), widget.name, widget.number,
                    widget.age, widget.level, finalScore.toString())
                .toJson())
            .then((_) {
          // ...
          questionNumber = 0;
          finalScore = 0;

          _showDialog("Quiz submitted successfully", false);
        });
      } else {
        questionNumber++;
        FirebaseTodos.getTodo(questionNumber.toString()).then(_updateTodo);
      }
    });
  }
}
