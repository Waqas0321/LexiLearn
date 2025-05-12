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
import '../controller/animals_quiz_controller.dart';

class AnimalsQuizScreen extends StatelessWidget {
  final AnimalsQuizController controller = Get.find();
  final AppSizes appSizes = AppSizes();

  AnimalsQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<QuestionModel>? questions = Get.arguments['questions'];
    final int quizIndex = Get.arguments['quizIndex'];
    controller.loadQuestions(questions!);
    return Scaffold(
      appBar: CustomAppBar(title: "🎉 Quiz Time!", goBack: true),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: appSizes.getCustomPadding(top: 0, left: 0, right: 0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Obx(
                  () => Expanded(
                child: ListView.builder(
                  padding: appSizes.getCustomPadding(),
                  itemCount: controller.questions.length,
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
                              fontSize: 18,
                              textAlign: TextAlign.start,
                              textOverflow: TextOverflow.visible,
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.orange,
                            ),
                            Gap(8),
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
                            ...question.options.map((option) {
                              final isSelected = selected == option;
                              Color backgroundColor = AppColors.white;
                              Color borderColor = AppColors.brown;
                              Color titleColor = AppColors.black;
                              if (isSelected) {
                                backgroundColor = AppColors.orange;
                                borderColor = AppColors.orange;
                                titleColor = AppColors.white;
                              }
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
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
                                        fontSize: 16,
                                        textColor: titleColor,
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
              ),
            ),
            Gap(8),
            Padding(
              padding: appSizes.getCustomPadding(top: 0,bottom: 0),
              child: Obx(
                    () => CustomElevatedButton(
                  isLoading: controller.isLoading.value,
                  onPress: () {
                    controller.submit(quizIndex);
                  },
                  text: "🚀 Submit Answers",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
