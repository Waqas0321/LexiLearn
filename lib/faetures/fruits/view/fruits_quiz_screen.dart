import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/Const/app_colors.dart';
import 'package:lexi_learn/core/utils/app_sizes.dart';
import 'package:lexi_learn/core/widgets/custom_appbar.dart';
import 'package:lexi_learn/core/widgets/custom_elevated_button.dart';
import 'package:lexi_learn/core/widgets/custom_text_widget.dart';
import '../../../core/Const/app_images.dart';
import '../../../data/models/question_model.dart';
import '../controller/fruits_quiz_controller.dart';

class FruitsQuizScreen extends StatelessWidget {
  final FruitsQuizController controller = Get.find();
  final AppSizes appSizes = AppSizes();

  FruitsQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<QuestionModel>? questions = Get.arguments['questions'];
    final int quizIndex = Get.arguments['quizIndex'];
    log(quizIndex);
    controller.loadQuestions(questions!);

    return Scaffold(
      appBar: CustomAppBar(title: "Quiz", goBack: true),
      body: Container(
        height: appSizes.getHeightPercentage(100),
        width: appSizes.getWidthPercentage(100),
        padding: appSizes.getCustomPadding(top: 0, left: 0, right: 0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Obx(() => Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.questions.length,
                padding: appSizes.getCustomPadding(),
                itemBuilder: (context, index) {
                  final question = controller.questions[index];
                  final submitted = controller.submitted.value;
                  return Obx(() {
                    final selected = controller.selectedAnswers[index];
                    return Card(
                      elevation: 4,
                      child: Padding(
                        padding: appSizes.getCustomPadding(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextWidget(
                              text: 'Q${index + 1}: ${question.question}',
                              fontWeight: FontWeight.w500,
                            ),
                            if (question.displayImage != null)
                              Image.asset(question.displayImage!,height: 50),
                            ...question.options.map((option) {
                              final isSelected = selected == option;
                              final isCorrect = question.correctAnswer == option;
                              Color tileColor = Colors.transparent;
                              if (submitted) {
                                if (isSelected && isCorrect) {
                                  tileColor = Colors.green.shade100;
                                } else if (isSelected && !isCorrect) {
                                  tileColor = Colors.red.shade100;
                                }
                              }
                              return Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: tileColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      value: option,
                                      groupValue: selected,
                                      activeColor: AppColors.orange,
                                      onChanged: submitted
                                          ? null
                                          : (value) {
                                        controller.selectedAnswers[index] = value!;
                                      },
                                    ),
                                    CustomTextWidget(
                                      text: option,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  });
                },
              ),
            )),
            Gap(8),
            Padding(
              padding: appSizes.getCustomPadding(top: 0, bottom: 0),
              child: CustomElevatedButton(
                isLoading: controller.isLoading.value,
                onPress: () {
                  controller.submit(quizIndex);
                },
                text: "Submit",
              ),
            )
          ],
        ),
      ),
    );
  }
}