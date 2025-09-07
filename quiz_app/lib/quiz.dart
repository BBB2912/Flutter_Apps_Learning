import 'package:flutter/material.dart';
import 'package:quiz_app/start_screen.dart';
import 'package:quiz_app/question_screen.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/results_screen.dart';

class Quiz extends StatefulWidget{
  const Quiz({super.key});

  @override
  State<Quiz> createState()=> _QuizState();

}

class _QuizState extends State<Quiz>{
  List<String> selectedAnswers=[];

  

  String? activeScreen;

  @override
  void initState() {
    super.initState();
    activeScreen = 'Start-Screen' ;
  }

  void chooseAnswer(String answer){
    selectedAnswers.add(answer);
    if(selectedAnswers.length == questions.length){
      setState(() {
        activeScreen='Results-Screen';
      });
      
    }
  }

  void switchScreen(){
    setState(() {
      activeScreen = 'Question-Screen'; // Assuming you have a QuestionsScreen widget
    });
  }

  void quizRestart(){
    setState(() {
      selectedAnswers=[];
      activeScreen='Question-Screen';
    });
  }
  

 @override
 Widget build(BuildContext context){

  Widget screenWidget= StartScreen(switchScreen);
  if(activeScreen == 'Question-Screen'){
    screenWidget = QuestionsScreen(onAnswerSelected: chooseAnswer);
  }

  if(activeScreen == 'Results-Screen'){
    screenWidget = ResultsScreen(selectedAnswers:selectedAnswers,quizRestart);
  }


  return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Quiz-App',
      home: Scaffold(
        body:Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 81, 2, 123),
                const Color.fromARGB(255, 165, 13, 207),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,

        ),
      ),
    );
 }
}