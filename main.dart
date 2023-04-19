import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizbrain = QuizBrain();

void main() {
  runApp(MyApp());
}

// Basic UI of the App
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          foregroundColor: Colors.white,
          title: Center(
            child: Text('IT is recyclable item or not?'),
          )
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

// Which is going to change the state of the widget
class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // To check whether user answer is correct or not
  bool isCorrect = false;

  // To keep track of our current position (with regards to the questions and answers)
  int counter = 0;
  int totalCorrect = 0;

  // To keep track of the score by adding some icons into it
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userChoice) {
    // if user clicked the true button and the answer is also true
    if (quizbrain.getAnswer() == userChoice) {
      isCorrect = true;
    }

    setState(
          () {
        // if user answer is correct
        if (isCorrect) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
          totalCorrect++;
        }
        // if user answer is incorrect
        else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }

        // reset the isCorrect value
        isCorrect = false;

        // if we are at the last question, reset to the first
        if (quizbrain.endOfQuestion()) {
          if (totalCorrect >= 5) {
            // Show the alert first
            Alert(
              context: context,
              type: AlertType.success,
              title: "Congratulation!",
              desc: "You have correct $totalCorrect questions",
              buttons: [
                DialogButton(
                  child: Text(
                    "Restart",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                )
              ],
            ).show();
          }
            else if (totalCorrect < 5){
            Alert(
              context: context,
              type: AlertType.error,
              title: "Oops!",
              desc: "You only correct $totalCorrect questions",
              buttons: [
                 DialogButton(
                  child: Text(
                    "Restart",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                )
              ],
            ).show();
          }

            quizbrain.resetCounter();
            scoreKeeper.clear();
            totalCorrect = 0;
        }
        // else we are going to proceed to the next question
        else {
          quizbrain.nextQuestion();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 7,
          child: Center(
            child: Column(
            children :[
              Text(
                quizbrain.getQuestion(),
                style: TextStyle(color: Colors.black, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Image.asset(
                quizbrain.getImage(),
                width: 200, // Adjust the width of the image
                height: 200, // Adjust the height of the image
              ),
      ],
         ),
        ),
        ),
        // This is the true button
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.green),
                  foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                  shape: MaterialStateProperty.resolveWith(
                          (states) => BeveledRectangleBorder())),
              child: Text('True'),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        // This is the false button
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.resolveWith((states) => Colors.red),
                  foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                  shape: MaterialStateProperty.resolveWith(
                          (states) => BeveledRectangleBorder())),
              child: Text('False'),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

/*
Question1: 'Are plants always green?', false,
Question2: 'Are boats always float?', false,
Question3: 'Approximately one quarter of human bones are in the feet', true,
* */