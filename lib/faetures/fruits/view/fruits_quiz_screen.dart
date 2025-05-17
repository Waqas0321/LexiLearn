import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/Const/app_colors.dart';
import 'package:lexi_learn/core/utils/app_sizes.dart';
import 'package:lexi_learn/core/widgets/custom_appbar.dart';
import 'package:lexi_learn/core/widgets/custom_elevated_button.dart';
import 'package:lexi_learn/core/widgets/custom_text_widget.dart';
import '../../../core/Const/app_images.dart';
import '../../../core/widgets/custom_dragable_tile.dart';
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
    controller.loadQuestions(questions!);
    return Scaffold(
      appBar: CustomAppBar(title: "🎉 Quiz Time!", goBack: true),
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
            Obx(() {
              double progress = 0;
              if (controller.questions.isNotEmpty) {
                int correctCount =
                    controller.questions.where((q) {
                      final matched = controller.matchedAnswers[q.id];
                      return matched != null && matched == q.correctAnswer;
                    }).length;
                progress = correctCount / controller.questions.length;
              }
              return Padding(
                padding: appSizes.getCustomPadding(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: 'Progress: ${(progress * 100).toStringAsFixed(0)}%',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.white,
                    ),
                    SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: AppColors.whitish,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.green,
                      ),
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ],
                ),
              );
            }),
            Obx(
              () => Expanded(
                child: Padding(
                  padding: appSizes.getCustomPadding(),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.questions.length,
                          itemBuilder: (context, index) {
                            final question = controller.questions[index];
                            final matchedAnswer =
                                controller.matchedAnswers[question.id];
                            final submitted = controller.submitted.value;
                            Color backgroundColor = AppColors.white;
                            Color borderColor = AppColors.brown;
                            Color textColor = AppColors.black;
                            if (matchedAnswer != null) {
                              if (matchedAnswer == question.correctAnswer) {
                                backgroundColor = AppColors.green;
                                borderColor = AppColors.green;
                                textColor = AppColors.white;
                              } else {
                                backgroundColor = AppColors.red;
                                borderColor = AppColors.red;
                                textColor = AppColors.white;
                              }
                            } else {
                              backgroundColor = AppColors.white;
                              textColor = AppColors.black;
                            }
                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.orange2,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.blackish,
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (question.displayImage != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        question.displayImage!,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  Gap(10),
                                  DragTarget<String>(
                                    builder: (
                                      context,
                                      candidateData,
                                      rejectedData,
                                    ) {
                                      return Container(
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: backgroundColor,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: borderColor,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: CustomTextWidget(
                                          text:
                                              matchedAnswer ??
                                              "Drop answer here",
                                          textColor: textColor,
                                        ),
                                      );
                                    },
                                    onWillAcceptWithDetails:
                                        (data) => !submitted,
                                    onAcceptWithDetails: (details) {
                                      if (!submitted) {
                                        controller.matchAnswer(
                                          question.id!,
                                          details.data,
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Gap(20),
                      SizedBox(
                        height: 110,
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 3.5,
                          physics: NeverScrollableScrollPhysics(),
                          children:
                              controller.shuffledOptions.map((answer) {
                                final isMatched = controller
                                    .matchedAnswers
                                    .values
                                    .contains(answer);
                                return Draggable<String>(
                                  data: answer,
                                  feedback: CustomDraggableTile(text: answer),
                                  childWhenDragging: Opacity(
                                    opacity: 0.4,
                                    child: CustomDraggableTile(text: answer),
                                  ),
                                  maxSimultaneousDrags:
                                      isMatched || controller.submitted.value
                                          ? 0
                                          : 1,
                                  child:
                                      isMatched
                                          ? Opacity(
                                            opacity: 0.3,
                                            child: CustomDraggableTile(
                                              text: answer,
                                            ),
                                          )
                                          : CustomDraggableTile(text: answer),
                                );
                              }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Gap(8),
            Padding(
              padding: appSizes.getCustomPadding(top: 0, bottom: 0),
              child: CustomElevatedButton(
                isLoading: controller.isLoading.value,
                onPress: () {
                  controller.submit(quizIndex);
                },
                text: "🚀 Submit Matches",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
