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
import '../../../data/models/colors_question_model.dart';
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
          appBar: CustomAppBar(
            title: "Colors",
            goBack: true,
            actionsWidgets: [
              StreamBuilder(
                stream: controller.getColorsQuizProgress(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: AppColors.white,)),
                    );
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.warning_amber,color: AppColors.white,),
                    );
                  } else if (!snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.warning_amber,color: AppColors.white,),
                    );
                  }

                  final quizIndex = snapshot.data!['quizIndex'];
                  double progress = [0.33, 0.66, 1.0][quizIndex.clamp(0, 2)];

                  return SizedBox(
                    height: 35,
                    width: 35,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          value: progress,
                          backgroundColor: AppColors.whitish,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
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
              Gap(18)
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
                                Icon(Icons.star, color: color.color, size: 52),
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
        final questions = group.map((color) {
          final otherOptions = [...group]..remove(color)..shuffle();
          final options = ([color.name] + otherOptions.take(3).map((e) => e.name).toList())..shuffle();

          return ColorsQuestionModel(
            question: "What is the name of this color?",
            options: options,
            correctAnswer: color.name,
            displayColor: color.color,
            isColorQuestion: true,
          );
        }).toList();
        questions.shuffle();
        Get.toNamed(
          AppRoutes.COLORSQUIZSCREEN,
          arguments: {
            'questions': questions,
            'quizIndex': quizIndex,
          },
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
