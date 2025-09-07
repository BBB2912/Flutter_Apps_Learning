import 'package:flutter/material.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem({super.key, required this.dataItem});

  final Map<String, Object> dataItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: dataItem['user_answer']==dataItem['correct_answer']
                  ?const Color.fromARGB(255, 150, 198, 241)
                  :const Color.fromARGB(255, 249, 133, 241),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                  child: Text(
                    ((dataItem['question_index']as int) +1).toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                    dataItem['question'].toString(),
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                    ),
                  const SizedBox(height: 5,),
                  Text(
                    dataItem['user_answer'].toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 202, 171, 252),
                    ),
                    ),
                  const SizedBox(height: 5,),
                  Text(
                    dataItem['correct_answer'].toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 181, 254, 246),
                    )
                    ),
                ],),
              )
            ],
            ),
      );
  }
}