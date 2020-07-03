import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
QuizBrain quizbrain=QuizBrain();
void main() {
  runApp(Quizzler());
}
class Quizzler extends  StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}
class QuizPage extends StatefulWidget{
  @override
  _QuizPageState createState()=> _QuizPageState();
}
class _QuizPageState extends State<QuizPage>{
  List<Icon> scoreKeeper=[];
  void checkAnswer(bool userpickedAnswer){
    bool correctAnswer=quizbrain.getCorrectAnswer();
    setState(() {

      //TODO: Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If so,

      //On the next line, you can also use if (quizBrain.isFinished()) {}, it does the same thing.

      if (quizbrain.isFinished() == true) {

        //TODO Step 4 Part A - show an alert using rFlutter_alert,
        //This is the code for the basic alert from the docs for rFlutter Alert:
        //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();
        //Modified for our purposes:
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();
        //TODO Step 4 Part C - reset the questionNumber,
        quizbrain.reset();
        //TODO Step 4 Part D - empty out the scoreKeeper.
        scoreKeeper = [];
      }
      //TODO: Step 6 - If we've not reached the end, ELSE do the answer checking steps below 👇

      else {
        if (correctAnswer == userpickedAnswer) {
          //print('user got it right');
          scoreKeeper.add(Icon(Icons.check, color: Colors.green,
          ),
          );
        }
        else {
          scoreKeeper.add(Icon(Icons.close, color: Colors.red,
          ),
          );
        }
        quizbrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
            flex:5,
            child: Padding(
              padding:EdgeInsets.all(10.0),
              child: Center(
                child:Text(
                  quizbrain.getQuestion(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ) ,
            )
        ),
        Expanded(
          child: Padding(
            padding:EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child:Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                // user pressed true,
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding:EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child:Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
                //the user picked false.
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

