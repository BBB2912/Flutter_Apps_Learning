import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/quiz_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(this.onRestart,{super.key,required this.selectedAnswers});

  final  void Function() onRestart;

  final List<String> selectedAnswers;
  

  List<Map<String,Object>> get quizSummary{
    final List<Map<String,Object>> summary = [];
    for(var i=0;i<questions.length;i++){
      summary.add({
        'question_index': i,
        'question':questions[i].questionText,
        'correct_answer': questions[i].options[0],
        'user_answer': selectedAnswers[i],
      });
    }
    return summary;
  }


  @override
  Widget build(BuildContext context) {
    final List<Map<String,Object>>  quizSummaryData=quizSummary;
    final int numberOfQuestions=questions.length;
    final int corectedQuestions= quizSummaryData.map((data){
      return data['user_answer']==data['correct_answer'];
    }).length;
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answerd  $corectedQuestions correctly out of $numberOfQuestions question'
            ),
            const SizedBox(height:30,),
            QuizSummary(summary: quizSummaryData),
            const SizedBox(height: 30,),
            TextButton.icon(
              onPressed: onRestart,
              icon: const Icon(Icons.refresh),
              label: Text(
                'ReStart'
              ),
              )
          ],
        ),
      ),
    );
  }
}