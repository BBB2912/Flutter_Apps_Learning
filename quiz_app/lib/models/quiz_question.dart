class QuizQuestion{
  final String questionText;
  final List<String> options;
  
  const QuizQuestion(this.questionText, this.options);

  List<String>  get shuffledAnswers{
  final shuffledOptions = List.of(options);
  shuffledOptions.shuffle();
  return shuffledOptions;
  } 
}