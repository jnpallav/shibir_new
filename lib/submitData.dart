import 'package:firebase_database/firebase_database.dart';

class SubmitData {
  String key;
  String name, number, age, level, score;
  DateTime dateTime;

  SubmitData(
      this.dateTime, this.name, this.number, this.age, this.level, this.score);

  SubmitData.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        dateTime =
            new DateTime.fromMillisecondsSinceEpoch(snapshot.value["date"]),
        name = snapshot.value["name"].toString(),
        number = snapshot.value["number"].toString(),
        age = snapshot.value["age"].toString(),
        level = snapshot.value["level"].toString(),
        score = snapshot.value["score"].toString();
  toJson() {
    return {
      "date": dateTime.millisecondsSinceEpoch,
      "name": name,
      "number": number,
      "age": age,
      "level": level,
      "score": score
    };
  }
}
