import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onAnswerSelected});

  final void Function(String answer) onAnswerSelected;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var questionIndex=0;
  // Assuming you want to display the first question
  
  void nextQuestion(String optionSelected){
    widget.onAnswerSelected(optionSelected);

    setState(() {
      questionIndex++;
    });
  }


  @override
  Widget build(BuildContext context) {
    final currentQuestion=questions[questionIndex]; 
    return Container(
      padding: const EdgeInsets.all(30),
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           Text(
            currentQuestion.questionText,
            style:const TextStyle(
              color:Colors.white,
              fontSize: 24,
            )
          ),
          const SizedBox(height: 30,),
          ...currentQuestion.shuffledAnswers.map((option){
            return AnswerButton(option: option, onTap: nextQuestion);
          }),
          const SizedBox(height: 30,),
      ],
      ),
    );
  }
}

