import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/Const/app_colors.dart';
import 'package:lexi_learn/core/utils/app_sizes.dart';
import 'package:lexi_learn/core/widgets/custom_appbar.dart';
import 'package:lexi_learn/core/widgets/custom_elevated_button.dart';
import 'package:lexi_learn/core/widgets/custom_text_widget.dart';
import 'package:lexi_learn/data/models/colors_question_model.dart';
import '../../../core/Const/app_images.dart';
import '../controller/colors_quiz_controller.dart';

class ColorsQuizScreen extends StatelessWidget {
  final ColorsQuizController controller = Get.find();
  final AppSizes appSizes = AppSizes();

  ColorsQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ColorsQuestionModel>? questions = Get.arguments['questions'];
    final int quizIndex = Get.arguments['quizIndex'];
    print(quizIndex);
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
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.orange2,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blackish,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            text: 'Q${index + 1} 🎈: ${question.question}',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            textOverflow: TextOverflow.visible,
                            textAlign: TextAlign.start,
                            textColor: AppColors.orange,
                          ),
                          if (question.displayColor != null)
                            Icon(Icons.star, color: question.displayColor, size: 70),
                          Gap(10),
                          ...question.options.map((option) {
                            final isSelected = selected == option;
                            Color tileColor = Colors.white;
                            Color borderColor = AppColors.brown;
                            Color textColor = AppColors.black;
                            Color backgroundColor = AppColors.white;
                            if (isSelected) {
                              tileColor = AppColors.white;
                              textColor = AppColors.white;
                              borderColor = AppColors.orange;
                              backgroundColor = AppColors.orange;
                            }
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: borderColor),
                              ),
                              child: Row(
                                children: [
                                  Radio<String>(
                                    value: option,
                                    groupValue: selected,
                                    activeColor: AppColors.white,
                                    onChanged: submitted
                                        ? null
                                        : (value) {
                                      controller.selectedAnswers[index] = value!;
                                    },
                                  ),
                                  Expanded(
                                    child: CustomTextWidget(
                                      text: option,
                                      textAlign: TextAlign.start,
                                      textColor: textColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
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
                text: "🚀 Submit Answers",
              ),
            )
          ],
        ),
      ),
    );
  }
}