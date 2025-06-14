import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/widgets/custom_toast_show.dart';
import 'package:lexi_learn/data/providers/firestore_provider.dart';
import '../../../data/models/question_model.dart';

class BodypartsQuizController extends GetxController {
  FireStoreProvider fireStore = FireStoreProvider();
  ToastClass toast = ToastClass();
  final RxInt currentPage = 0.obs;

  var submitted = false.obs;
  var questions = <QuestionModel>[].obs;
  RxBool isLoading = false.obs;
  RxList<String> shuffledOptions = <String>[].obs;

  void loadQuestions(List<QuestionModel> newQuestions) {
    questions.value = newQuestions;
    final allOptions = newQuestions.expand((q) => q.options).toSet().toList();
    allOptions.shuffle();
    shuffledOptions.assignAll(allOptions);
    matchedAnswers.clear();
    submitted.value = false;
  }

  double get correctAnswerPercentage {
    if (questions.isEmpty) return 0.0;
    int correctCount =
        questions.where((q) {
          final matched = matchedAnswers[q.id];
          return matched != null && matched == q.correctAnswer;
        }).length;
    return correctCount / questions.length;
  }

  int getScore() {
    int score = 0;
    for (var q in questions) {
      if (matchedAnswers[q.id] == q.correctAnswer) {
        score++;
      }
    }
    return score;
  }

  void submit(int quizIndex) async {
    try {
      isLoading.value = true;
      final data = prepareQuizData(quizIndex);
      await storeQuizData(data);
      submitted.value = true;
      isLoading.value = false;
      showQuizResultToast();
      Get.back();
    } catch (e) {
      isLoading.value = false;
      handleSubmissionError(e);
    }
  }

  Map<String, dynamic> prepareQuizData(int quizIndex) {
    return {
      'quizIndex': quizIndex,
      'timestamp': FieldValue.serverTimestamp(),
      'matchedAnswers': matchedAnswers,
    };
  }

  Future<void> storeQuizData(Map<String, dynamic> data) async {
    await fireStore.storeDataWithUserID(
      collectionName: "body_parts_quiz",
      data: data,
      toJson: (data) => data,
    );
  }

  void showQuizResultToast() {
    final score = getScore();
    if(score > 2){
      toast.showCustomToast("Good effort you attempt best");
    }else{
      toast.showCustomToast("Good but do effort for better");
    }
  }

  void handleSubmissionError(dynamic error) {
    log("Error during quiz submission: $error");
    toast.showCustomToast(
      "An error occurred while submitting the quiz. Please try again.",
    );
  }

  PageController pageController = PageController();
  var matchedAnswers = <String, String>{}.obs;
  void matchAnswer(String questionId, String selectedOption) {
    matchedAnswers[questionId] = selectedOption;
    matchedAnswers.refresh();
  }



  @override
  void onClose() {
    questions.clear();
    matchedAnswers.clear();
    submitted.value = false;
    super.onClose();
  }
}
