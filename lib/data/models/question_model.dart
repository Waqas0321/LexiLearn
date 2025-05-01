class QuestionModel {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String? displayImage;
  final bool isColorQuestion;

  QuestionModel({
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.displayImage,
    this.isColorQuestion = false,
  });
}
