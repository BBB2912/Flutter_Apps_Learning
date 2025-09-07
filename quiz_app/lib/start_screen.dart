import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget{
  const StartScreen(this.startQuiz,{super.key});

  final void Function() startQuiz;
  @override
  Widget build(BuildContext context){
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/quiz-logo.png',
                width:300,
                height:300,
                color: const Color.fromARGB(154, 255, 255, 255),
              ),
              const SizedBox(height: 40),
              const Text(
                'Learn Flutter he fun way !',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                

                ),
              ),
              const SizedBox(height: 40),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side:const BorderSide(
                    width: 0,
                  ),
                ),
                onPressed: startQuiz,
                icon: const Icon(Icons.arrow_right_alt,
                color: Colors.white,
                ),
                iconAlignment:IconAlignment.end ,
                label: const Text(
                  'Start Quiz',
                  style:TextStyle(
                    color:Colors.white,
                    fontSize:10,
                    fontWeight: FontWeight.bold,
                  )
                ),
              ),
            ],
          );
  }
}