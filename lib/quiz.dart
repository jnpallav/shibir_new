//import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:firebase_database/ui/firebase_animated_list.dart';

var finalScore = 0;
var questionNumber = 0;
var quiz = new AnimalQuiz();

class AnimalQuiz {
  var images = ["alligator", "cat", "dog", "owl"];

  var questions = [
    "This animal is a carnivorous reptile.",
    "_________ like to chase mice and birds.",
    "Give a _________ a bone and he will find his way home",
    "A nocturnal animal with some really big eyes",
  ];

  var choices = [
    ["Cat", "Sheep", "Alligator", "Cow"],
    ["Cat", "Snail", "Slug", "Horse"],
    ["Mouse", "Dog", "Elephant", "Donkey"],
    ["Spider", "Snake", "Hawk", "Owl"]
  ];

  var correctAnswers = ["Alligator", "Cat", "Dog", "Owl"];
}

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

class Quiz1 extends StatefulWidget {
  final String name, number, age, level;

  Quiz1({Key key, this.name, this.number, this.age, this.level})
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

  @override
  void initState() {
    // TODO: implement initState

    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.child("Quiz").once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      debugPrint(keys);
      debugPrint(data);
      //allData.clear();
    });

    super.initState();
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
                          "Question ${questionNumber + 1} of ${quiz.questions.length}",
                          style: new TextStyle(fontSize: 22.0),
                        ),
                        //new Text("Score: $finalScore",style: new TextStyle(fontSize: 22.0),)
                      ],
                    ),
                  ),

                  //image
                  new Padding(padding: EdgeInsets.all(10.0)),

                  new Image.asset(
                    "assets/${quiz.images[questionNumber]}.jpg",
                  ),

                  new Padding(padding: EdgeInsets.all(10.0)),

                  new Text(
                    quiz.questions[questionNumber],
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
                        quiz.choices[questionNumber][0],
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
                        quiz.choices[questionNumber][1],
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
                        quiz.choices[questionNumber][2],
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
                        quiz.choices[questionNumber][3],
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
                          onPressed: sendData,
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

      switch (_radioValue) {
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
      }
    });
  }

  void resetQuiz() {
    setState(() {
      Navigator.pop(context);
      finalScore = 0;
      questionNumber = 0;
    });
  }

  void sendData() {
    //databaseReference.push().set({'name': 'kded', 'lastName': 'qde'});
  }

  void nextQuestion() {
    setState(() {
      if (_radioValue != -1) {
        if (quiz.choices[questionNumber][_radioValue] ==
            quiz.correctAnswers[questionNumber]) {
          finalScore++;
        }
        _radioValue = -1;
        updateQuestion();
      } else {
        _showDialog();
      }
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Choose any one option"),
          //content: new Text("Choose any one option"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void updateQuestion() {
    setState(() {
      if (questionNumber == quiz.questions.length - 1) {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new Summary(
                      score: finalScore,
                    )));
      } else {
        questionNumber++;
      }
    });
  }
}

class Summary extends StatelessWidget {
  final int score;
  Summary({Key key, @required this.score}) : super(key: key);

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
                  questionNumber = 0;
                  finalScore = 0;
                  Navigator.pop(context);
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
