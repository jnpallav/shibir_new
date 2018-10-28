import 'submitData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResultListItem extends StatelessWidget {
  final SubmitData submitData;

  ResultListItem(this.submitData);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Padding(
      padding: new EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new Expanded(
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Column(
                  children: [
                    new Text(
                      submitData.name,
                      textScaleFactor: 1.5,
                      textAlign: TextAlign.left,
                    ),
                    new Text(
                      submitData.level,
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.right,
                      style: new TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                ),
              ],
            ),
          ),
          new Text(
            submitData.score.toString(),
            textScaleFactor: 2.0,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/*new Text(
                      new DateFormat.MMMEd().format(submitData.dateTime),
                      textScaleFactor: 0.9,
                      textAlign: TextAlign.left,
                    ),
                    new Text(
                      new TimeOfDay.fromDateTime(submitData.dateTime)
                          .toString(),
                      textScaleFactor: 0.8,
                      textAlign: TextAlign.right,
                      style: new TextStyle(
                        color: Colors.grey,
                      ),
                    ),*/
