import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/Const/app_colors.dart';
import 'package:lexi_learn/core/utils/app_sizes.dart';
import 'package:lexi_learn/core/widgets/custom_appbar.dart';
import 'package:lexi_learn/faetures/alphabets/controller/alphabets_controller.dart';
import '../../../core/Const/app_images.dart';
import '../../../core/helpers/bottom_curve_clipper.dart';
import '../tracing/view/tracing_screen.dart';

class AlphabetDetailScreen extends StatelessWidget {
  final AlphabetsController controller = Get.find();
  final AppSizes appSizes = AppSizes();
  AlphabetDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: CustomAppBar(title: '', goBack: true),
          body: Container(
            height: appSizes.getHeightPercentage(100),
            width: appSizes.getWidthPercentage(100),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.background),
                fit: BoxFit.cover,
              ),
            ),
            child: Obx(() {
              final currentAlphabet = controller.alphabet[controller.currentIndex.value];

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipPath(
                    clipper: BottomCurveClipper(),
                    child: Container(
                      width: double.infinity,
                      padding: appSizes.getCustomPadding(),
                      color: AppColors.white,
                      child: Column(
                        children: [
                          const Gap(16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: controller.previous,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: AppColors.blackish,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: AppColors.white,
                                    size: 28,
                                  ),
                                ),
                              ),
                              Image.asset(
                                currentAlphabet.imagePath,
                                height: 90,
                              ),
                              GestureDetector(
                                onTap: controller.next,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: AppColors.blackish,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: AppColors.white,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(30),

                          // 📷 Reference Image
                          Image.asset(
                            currentAlphabet.referenceImagePath,
                            height: 130,
                            width: 130,
                          ),

                          const Gap(30),

                          //  Refresh Icon
                          GestureDetector(
                            onTap: controller.reListen,
                            child: const Icon(
                              Icons.refresh,
                              color: AppColors.blackish,
                              size: 40,
                            ),
                          ),

                          const Gap(20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blackish,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Get.to(() => TracingScreen(
                                alphabet: currentAlphabet, // pass full object
                              ));
                            },
                            child: const Text(
                              'Trace Letter',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),

                          const Gap(20),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
