import 'dart:ui';

class ColorsQuestionModel {
  final String question;
  final String id;
  final List<String> options;
  final String correctAnswer;
  final Color? displayColor;
  final bool isColorQuestion;

  ColorsQuestionModel( {
    required this.question,
    required this.id,
    required this.options,
    required this.correctAnswer,
    this.displayColor,
    this.isColorQuestion = false,
  });
}
