import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/app_routes/routes.dart';
import 'package:lexi_learn/core/utils/app_sizes.dart';
import 'package:lexi_learn/faetures/colors/controller/colors_controller.dart';
import '../../../core/Const/app_colors.dart';
import '../../../core/Const/app_images.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_text_widget.dart';
import '../../../data/models/question_model.dart';
import 'color_detail_screen.dart';

class ColorsScreen extends StatelessWidget {
  ColorsScreen({super.key});

  final ColorsController controller = Get.find<ColorsController>();
  final appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: CustomAppBar(title: "Colors", goBack: true),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Gap(appSizes.getHeightPercentage(7)),
                  Obx(() {
                    final colors = controller.colors;
                    final quizInterval = 4;
                    final totalItems =
                        colors.length + (colors.length ~/ quizInterval);

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
                          final quizIndex =
                              index ~/
                              (quizInterval +
                                  1); // 0 for first quiz, 1 for second...
                          return buildQuizTile(quizIndex);
                        }
                        final colorIndex =
                            index - (index ~/ (quizInterval + 1));
                        final color = colors[colorIndex];
                        return GestureDetector(
                          onTap: () {
                            controller.setIndex(colorIndex);
                            Get.to(() => ColorDetailScreen());
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
                            child: Column(
                              children: [
                                Icon(Icons.star, color: color.color, size: 42),
                                CustomTextWidget(
                                  text: color.name,
                                  fontSize: 12,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ],
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
        final allColors = controller.colors;
        final groupSize = 4;
        final start = quizIndex * groupSize;
        if (start >= allColors.length) return;
        final end = min(start + groupSize, allColors.length);
        final group = allColors.sublist(start, end);
        final questions =
            group.map((color) {
              final otherOptions =
                  [...group]
                    ..remove(color)
                    ..shuffle();
              final options =
                  ([color.name] +
                        otherOptions.take(3).map((e) => e.name).toList())
                    ..shuffle();

              return QuestionModel(
                question: "What is the name of this color?",
                options: options,
                correctAnswer: color.name,
                displayColor: color.color,
                isColorQuestion: true,
              );
            }).toList();
        questions.shuffle();
        Get.toNamed(AppRoutes.QUIZSCREEN, arguments: {'questions': questions});
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
