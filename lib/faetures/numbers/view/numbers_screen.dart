import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/utils/app_sizes.dart';
import 'package:lexi_learn/faetures/numbers/controller/numbers_controller.dart';
import 'package:lexi_learn/faetures/numbers/view/number_detail_screen.dart';
import '../../../core/Const/app_colors.dart';
import '../../../core/Const/app_images.dart';
import '../../../core/app_routes/routes.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_text_widget.dart';
import '../../../data/models/question_model.dart';

class NumbersScreen extends StatelessWidget {
  NumbersScreen({super.key});

  final NumbersController controller = Get.find<NumbersController>();
  final appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "Counting",
            goBack: true,
            actionsWidgets: [
              StreamBuilder(
                stream: controller.getAllCountingQuizProgress(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.warning_amber, color: AppColors.white),
                    );
                  } else if (!snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.warning_amber, color: AppColors.white),
                    );
                  }
                  final quizIndex = snapshot.data!['quizIndex'];
                  double progress =
                  [0.20, 0.40, 0.60, 0.80, 1.0][quizIndex.clamp(0, 4)];
                  return SizedBox(
                    height: 35,
                    width: 35,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          value: progress,
                          backgroundColor: AppColors.whitish,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.white,
                          ),
                          strokeWidth: 4,
                        ),
                        Center(
                          child: CustomTextWidget(
                            text: "${(progress * 100).toInt()}%",
                            textColor: AppColors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Gap(18),
            ],
          ),
          body: Container(
            height: appSizes.getHeightPercentage(100),
            width: appSizes.getWidthPercentage(100),
            padding: appSizes.getCustomPadding(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.background),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() {
                      final counting = controller.numbers;
                      final quizInterval = 4;
                      final totalItems =
                          counting.length + (counting.length ~/ quizInterval);
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: totalItems,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          if ((index + 1) % (quizInterval + 1) == 0) {
                            final quizIndex = index ~/ (quizInterval + 1);
                            return buildQuizTile(quizIndex);
                          }
                          final colorIndex =
                              index - (index ~/ (quizInterval + 1));
                          final color = counting[colorIndex];
                          return GestureDetector(
                            onTap: () {
                              controller.setIndex(colorIndex);
                              Get.to(() => NumberDetailScreen());
                            },
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                border: Border.all(
                                  color: AppColors.orange,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(child: Image.asset(
                                  color.imagePath, height: 50)),
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildQuizTile(int quizIndex) {
    return GestureDetector(
      onTap: () {
        final allNumbers = controller.numbers;
        final groupSize = 4;
        final start = quizIndex * groupSize;
        if (start >= allNumbers.length) return;
        final end = min(start + groupSize, allNumbers.length);
        final group = allNumbers.sublist(start, end);
        final questions =
        group.map((numbers) {
          final otherOptions =
          [...group]
            ..remove(numbers)
            ..shuffle();
          final options =
          ([numbers.name] +
              otherOptions.take(3).map((e) => e.name).toList())
            ..shuffle();

          return QuestionModel(
            question: "What is the name of this thing?",
            options: options,
            correctAnswer: numbers.name,
            displayImage: numbers.referenceImagePath,
            isColorQuestion: true,
            id: numbers.name,
          );
        }).toList();
        questions.shuffle();
        Get.toNamed(
          AppRoutes.NUMBERSQUIZSCREEN,
          arguments: {'questions': questions, 'quizIndex': quizIndex},
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.amber.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.amber, width: 2),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.quiz, color: AppColors.orange, size: 36),
              const SizedBox(height: 8),
              const CustomTextWidget(
                text: "Quiz Time!",
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
