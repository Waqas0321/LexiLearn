class QuestionModel {
  final String? id; // Unique ID for matching
  final String question; // The prompt/question text
  final List<String> options; // List of possible match answers
  final String correctAnswer; // Correct matching answer
  final String? displayImage; // Optional image for the question
  final bool isColorQuestion; // Optional flag, keep if needed

  QuestionModel({
    this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.displayImage,
    this.isColorQuestion = false,
  });
}
