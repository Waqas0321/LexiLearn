import 'dart:ui';

class QuestionModel {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final Color? displayColor;
  final bool isColorQuestion;

  QuestionModel({
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.displayColor,
    this.isColorQuestion = false,
  });
}
