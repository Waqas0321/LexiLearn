import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/widgets/custom_toast_show.dart';
import 'package:lexi_learn/data/providers/firestore_provider.dart';
import '../../../data/models/question_model.dart';

class AnimalsQuizController extends GetxController {
  FireStoreProvider fireStore = FireStoreProvider();
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

  void submit(int quizIndex) {
    try {
      final data = prepareQuizData(quizIndex);
      storeQuizData(data);
      submitted.value = true;
      showQuizResultToast();
      Get.back();
    } catch (e) {
      handleSubmissionError(e);
    }
  }

  Map<String, dynamic> prepareQuizData(int quizIndex) {
    return {
      'quizIndex': quizIndex,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }

  void storeQuizData(Map<String, dynamic> data) {
    fireStore.storeDataWithUserID(
      collectionName: "animals_quiz",
      data: data,
      toJson: (data) => data,
    );
  }

  void showQuizResultToast() {
    final score = getScore();
    final totalQuestions = questions.length;
    toast.showCustomToast(
      "You scored $score out of $totalQuestions",
    );
  }

  void handleSubmissionError(dynamic error) {
    log("Error during quiz submission: $error");
    toast.showCustomToast("An error occurred while submitting the quiz. Please try again.");
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
