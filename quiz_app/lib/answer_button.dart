import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({super.key,required this.option,required this.onTap});

  final String option;
  final void Function(String option) onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 82, 2, 96),
          foregroundColor: Colors.white,
        ),
        onPressed: (){
          return onTap(option); // Pass the option to the onTap function
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:10, horizontal: 20),
          child: Text(
            option,
            textAlign: TextAlign.center,
            style:TextStyle(
              color: Colors.white,
              fontSize: 16,
            )
          ),
        )
        ),
    );
  }
}