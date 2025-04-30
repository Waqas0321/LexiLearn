import 'package:get/get.dart';
import 'package:lexi_learn/core/widgets/custom_toast_show.dart';
import '../../../data/models/question_model.dart';

class QuizController extends GetxController {
  ToastClass toast = ToastClass();
  var submitted = false.obs;
  var selectedAnswers = <int, String>{}.obs;
  var questions = <QuestionModel>[].obs;
  RxBool isLoading = false.obs;

  void loadQuestions(List<QuestionModel> newQuestions) {
    questions.value = newQuestions;
    selectedAnswers.clear();
    submitted.value = false;
  }

  int getScore() {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i].correctAnswer) {
        score++;
      }
    }
    return score;
  }

  void submit() {
    submitted.value = true;
    toast.showCustomToast(
      "You scored ${getScore()} out of ${questions.length}",
    );
    Get.back();
  }

  void resetQuiz() {
    submitted.value = false;
    selectedAnswers.clear();
  }

  @override
  void onClose() {
    questions.clear();
    selectedAnswers.clear();
    submitted.value = false;
    super.onClose();
  }
}
