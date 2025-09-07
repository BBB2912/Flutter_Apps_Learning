import 'package:flutter/material.dart';
import 'package:quiz_app/questionsSummaryItem.dart';

class QuizSummary extends StatelessWidget {
  const QuizSummary({super.key,required this.summary});

  final List<Map<String, Object>> summary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summary.map((dataItem){
            return SummaryItem(dataItem:dataItem);
          }).toList(),
        ),
      ),
    );
  }
}