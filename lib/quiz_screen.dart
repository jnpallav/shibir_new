import 'package:flutter/material.dart';
import './quiz.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  List<DropdownMenuItem<String>> ageDrop = [];
  List<String> age = ["10-15", "15-25", "25-40", "45+"];
  List<DropdownMenuItem<String>> level = [];
  List<String> levelTopic = ["Easy", "Medium", "High"];

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String name, number;

  String selectedAge = null;
  String selectedLevel = null;

  var _textName = new TextEditingController();
  var _textNumber = new TextEditingController();
  //var _textAge = new TextEditingController();
  //var _textLevel = new TextEditingController();
  void loadData() {
    ageDrop = [];
    ageDrop = age
        .map((val) => new DropdownMenuItem<String>(
              child: new Text(val),
              value: val,
            ))
        .toList();

    level = [];
    level = levelTopic
        .map((val) => new DropdownMenuItem<String>(
              child: new Text(val),
              value: val,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    loadData();
    return Scaffold(
      body: new SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.all(15.0),
          child: new Form(key: _key, autovalidate: _validate, child: formUI()),
        ),
      ),
    );
  }

  Widget formUI() {
    return new Column(
      children: <Widget>[
        SizedBox(height: 30.0),
        Image.asset(
          'assets/jainprateek.png',
          height: 100.0,
        ),
        SizedBox(height: 30.0),
        Text('SHIBIR'),

        SizedBox(height: 15.0),

        TextFormField(
          decoration: InputDecoration(
            filled: true,
            hintText: 'Name',
          ),
          keyboardType: TextInputType.text,
          maxLength: 25,
          validator: validateName,
          controller: _textName,
          onSaved: (String val) {
            name = val;
          },
        ),
// spacer
        SizedBox(height: 12.0),
//mobile number
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            hintText: 'Mobile Number',
          ),
          keyboardType: TextInputType.phone,
          maxLength: 10,
          validator: validateNumber,
          controller: _textNumber,
          onSaved: (String val) {
            number = val;
          },
        ),
        SizedBox(height: 12.0),
//dropdown
        DropdownButton(
          value: selectedAge,
          items: ageDrop,
          elevation: 16,
          hint: new Text("Select Age"),
          onChanged: (value) {
            setState(() {
              selectedAge = value;
            });
          },
        ),
        //dropdown
        SizedBox(height: 12.0),
        DropdownButton(
          value: selectedLevel,
          items: level,
          elevation: 16,
          hint: new Text("Select level"),
          onChanged: (value) {
            setState(() {
              selectedLevel = value;
            });
          },
        ),
        new ButtonBar(
          children: <Widget>[
            new RaisedButton(
              child: Text('Start Quiz'),
              onPressed: startQuiz,
            ),
          ],
        ),
      ],
    );
  }

  String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);

    if (value.length == 0) {
      return "Name is required";
    } else if (!regExp.hasMatch(value)) {
      return "name must be a-z";
    } else {
      return null;
    }
  }

  String validateNumber(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Number is required";
    } else if (value.length != 10) {
      return "mobile number be 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "mobile must be digits";
    } else {
      return null;
    }
  }

  void _showDialog(String message) {
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void startQuiz() {
    if (_key.currentState.validate()) {
      if (selectedAge == null) {
        _showDialog("Select Age");
      } else if (selectedLevel == null) {
        _showDialog("Select Level");
      } else {
        //no error in validation
        _key.currentState.save();
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new Quiz1(
                    name: _textName.text,
                    number: _textNumber.text,
                    age: selectedAge,
                    level: selectedLevel)));
      }
    } else {
      setState(() {
        _validate = true;
      });
    }
  }
}

/*new FlatButton(
              child: Text('CANCEL'),
              onPressed: () {},
            ),*/
