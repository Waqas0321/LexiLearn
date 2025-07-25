import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/Const/app_colors.dart';
import 'package:lexi_learn/core/utils/app_sizes.dart';
import 'package:lexi_learn/core/widgets/custom_appbar.dart';
import 'package:lexi_learn/faetures/numbers/controller/numbers_controller.dart';
import '../../../core/Const/app_images.dart';
import '../../../core/app_routes/routes.dart';
import '../../../core/helpers/bottom_curve_clipper.dart';

class NumberDetailScreen extends StatelessWidget {
  final NumbersController controller = Get.find();
  final AppSizes appSizes = AppSizes();

  NumberDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: CustomAppBar(title: '', goBack: true),
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
            child: Obx(() {
              final currentNumber =
                  controller.numbers[controller.currentIndex.value];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipPath(
                    clipper: BottomCurveClipper(),
                    child: Container(
                      height: appSizes.getHeightPercentage(60),
                      width: appSizes.getWidthPercentage(100),
                      padding: appSizes.getCustomPadding(),
                      color: AppColors.white,
                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: controller.previous,
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: AppColors.blackish,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.arrow_back_ios_new,
                                      color: AppColors.white,
                                      size: 28,
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  currentNumber.imagePath,
                                  height: 60,
                                ),
                                GestureDetector(
                                  onTap: controller.next,
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: AppColors.blackish,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: AppColors.white,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Image.asset(
                              currentNumber.referenceImagePath,
                              height: 180,
                              width: 180,
                            ),
                            Gap(30),
                            GestureDetector(
                              onTap: controller.reListen,
                              child: Icon(
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
                                Get.toNamed(AppRoutes.TRACINGSCREEN,arguments: {
                                  "alphabet": currentNumber.number,
                                  "isAlphabet":false,
                                });
                              },
                              child: const Text(
                                'Trace Letter',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                            Gap(20),
                          ],
                        ),
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
