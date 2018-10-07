import 'package:firebase_database/firebase_database.dart';

class MyData {
  String key;
  String question, choice1, choice2, choice3, choice4, answer;

  MyData(this.question, this.choice1, this.choice2, this.choice3, this.choice4,
      this.answer);

  MyData.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        question = snapshot.value["question"],
        choice2 = snapshot.value["choice2"].toString(),
        choice3 = snapshot.value["choice3"].toString(),
        choice4 = snapshot.value["choice4"].toString(),
        answer = snapshot.value["answer"].toString(),
        choice1 = snapshot.value["choice1"].toString();
}
