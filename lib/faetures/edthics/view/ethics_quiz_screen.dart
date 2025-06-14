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
import '../controller/ethics_quiz_controller.dart';

class EthicsQuizScreen extends StatelessWidget {
  final EthicsQuizController controller = Get.put(EthicsQuizController());
  final AppSizes appSizes = AppSizes();

  EthicsQuizScreen({super.key});

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
                        child: PageView.builder(
                          controller: controller.pageController,
                          itemCount: controller.questions.length,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (index) {
                            controller.currentPage.value = index;
                          },
                          itemBuilder: (context, index) {
                            final question = controller.questions[index];
                            return Padding(
                              padding: appSizes.getCustomPadding(
                                top: 0,
                                bottom: 0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (question.displayImage != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        question.displayImage!,
                                        height: 160,
                                        width: double.infinity,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  Gap(20),
                                  Obx(() {
                                    final matchedAnswer =
                                        controller.matchedAnswers[question.id];
                                    final submitted =
                                        controller.submitted.value;
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: question.options.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 12,
                                            mainAxisSpacing: 12,
                                            childAspectRatio: 1.5,
                                          ),
                                      itemBuilder: (context, index) {
                                        final option = question.options[index];
                                        final bool isSelected =
                                            matchedAnswer == option;
                                        final bool isCorrect =
                                            option == question.correctAnswer;

                                        Color backgroundColor = AppColors.white;
                                        Color borderColor = AppColors.brown;
                                        Color textColor = AppColors.black;

                                        if (submitted) {
                                          if (isCorrect) {
                                            backgroundColor = AppColors.green;
                                            textColor = AppColors.white;
                                          } else if (isSelected && !isCorrect) {
                                            backgroundColor = AppColors.red;
                                            textColor = AppColors.white;
                                          }
                                        } else if (isSelected) {
                                          backgroundColor = AppColors.orange2;
                                          if (isCorrect) {
                                            backgroundColor = AppColors.green;
                                            textColor = AppColors.white;
                                            borderColor = AppColors.green;
                                          }
                                        }

                                        return GestureDetector(
                                          onTap: () {
                                            if (!submitted) {
                                              controller.matchAnswer(
                                                question.id!,
                                                option,
                                              );
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(14),
                                            decoration: BoxDecoration(
                                              color: backgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: borderColor,
                                              ),
                                            ),
                                            child: Center(
                                              child: CustomTextWidget(
                                                text: option,
                                                textColor: textColor,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }),
                                  Gap(appSizes.getHeightPercentage(7)),
                                  Row(
                                    mainAxisAlignment:
                                    index > 0
                                        ? MainAxisAlignment.spaceBetween
                                        : MainAxisAlignment.end,
                                    children: [
                                      if (index > 0)
                                        GestureDetector(
                                          onTap: () {
                                            controller.pageController
                                                .previousPage(
                                              duration: const Duration(
                                                milliseconds: 300,
                                              ),
                                              curve: Curves.ease,
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: AppColors.blackish,
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.arrow_back_ios_new,
                                                  size: 25,
                                                  color: AppColors.white,
                                                ),
                                                CustomTextWidget(
                                                  text: "Previous",
                                                  textColor: AppColors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                Gap(4),
                                              ],
                                            ),
                                          ),
                                        ),
                                      if (index <
                                          controller.questions.length - 1)
                                        GestureDetector(
                                          onTap: () {
                                            controller.pageController.nextPage(
                                              duration: const Duration(
                                                milliseconds: 300,
                                              ),
                                              curve: Curves.ease,
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: AppColors.blackish,
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                Gap(4),
                                                CustomTextWidget(
                                                  text: "Next",
                                                  textColor: AppColors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: AppColors.white,
                                                  size: 25,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Gap(8),
            Obx(() {
              bool isLastPage =
                  controller.currentPage.value ==
                  controller.questions.length - 1;

              return Visibility(
                visible: isLastPage,
                child: Padding(
                  padding: appSizes.getCustomPadding(top: 0, bottom: 3),
                  child: CustomElevatedButton(
                    isLoading: controller.isLoading.value,
                    onPress: () {
                      controller.submit(quizIndex);
                    },
                    text: "🚀 Submit Answers",
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
