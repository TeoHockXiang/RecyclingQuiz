import 'quiz.dart';
import 'dart:math';

// QuizBrain has list of Question objects
class QuizBrain {
  int counter = 0;
  int imageNumber = 1;
  int answeredQuestion = 0;

  // To keep the questions and answers as matching pairs in a list object
  List<Question> _questionBank = [
    Question(text: 'Aluminium Cans', answer: true),
    Question(text: 'Glass', answer: true),
    Question(text: 'Cloth', answer: true),
    Question(text: 'Metal', answer: true),
    Question(text: 'Paper', answer: true),
    Question(text: 'Battery', answer: false),
    Question(text: 'Kitchen waste', answer: false),
    Question(text: 'Light blue', answer: false),
    Question(text: 'Leaves', answer: false),
    Question(text: 'Thermometer', answer: false),
  ];


  void nextQuestion() {
    counter = Random().nextInt(10);
    imageNumber = counter + 1;
    answeredQuestion++;
  }

  String getQuestion() {
    return _questionBank[counter].text;
  }

  String getImage(){
    return 'images/Image$imageNumber.jpeg';
  }

  bool getAnswer() {
    return _questionBank[counter].answer;
  }

  void resetCounter() {
    answeredQuestion = 0;
  }

  bool endOfQuestion() {
    if (answeredQuestion == 9) {
      return true;
    } else {
      return false;
    }
  }
}