import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'submitData.dart';
import 'result_list_item.dart';

class ResultScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ResultScreenState();
  }
}

final mainReference = FirebaseDatabase.instance.reference().child('result');

class _ResultScreenState extends State<ResultScreen> {
  _ResultScreenState() {
    mainReference.onChildAdded.listen(_onEntryAdded);
  }
  List<SubmitData> weightSaves = new List();
  ScrollController _listViewScrollController = new ScrollController();
  double _itemExtent = 50.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new ListView.builder(
        shrinkWrap: true,
        controller: _listViewScrollController,
        itemCount: weightSaves.length,
        itemBuilder: (buildContext, index) {
          return new InkWell(
              child: new ResultListItem(weightSaves[index]));
        },
      ),
    );
  }

  _onEntryAdded(Event event) {
    setState(() {
      weightSaves.add(new SubmitData.fromSnapshot(event.snapshot));
      weightSaves.sort((we1, we2) => we1.dateTime.compareTo(we2.dateTime));
    });
    _scrollToTop();
  }

  _scrollToTop() {
    _listViewScrollController.animateTo(
      weightSaves.length * _itemExtent,
      duration: const Duration(microseconds: 1),
      curve: new ElasticInCurve(0.01),
    );
  }
}
