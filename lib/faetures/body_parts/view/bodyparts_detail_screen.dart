import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/Const/app_colors.dart';
import 'package:lexi_learn/core/utils/app_sizes.dart';
import 'package:lexi_learn/core/widgets/custom_appbar.dart';
import 'package:lexi_learn/core/widgets/custom_text_widget.dart';
import 'package:lexi_learn/faetures/body_parts/controller/body_parts_controller.dart';
import '../../../core/Const/app_images.dart';
import '../../../core/helpers/bottom_curve_clipper.dart';

class BodypartsDetailScreen extends StatelessWidget {
  final BodyPartsController controller = Get.find();
  final AppSizes appSizes = AppSizes();

  BodypartsDetailScreen({super.key});

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
              final currentBodyparts =
              controller.bodyparts[controller.currentIndex.value];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipPath(
                    clipper: BottomCurveClipper(),
                    child: Container(
                      height: appSizes.getHeightPercentage(50),
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
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: AppColors.blackish,
                                    size: 28,
                                  ),
                                ),
                                Image.asset(currentBodyparts.imagePath,height: 130),
                                GestureDetector(
                                  onTap: controller.next,
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: AppColors.blackish,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            CustomTextWidget(
                              text: currentBodyparts.name.toUpperCase(),
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              textColor: AppColors.orange,
                            ),
                            Gap(60),
                            GestureDetector(
                              onTap: controller.reListen,
                              child: Icon(
                                Icons.refresh,
                                color: AppColors.blackish,
                                size: 40,
                              ),
                            ),
                            Gap(45),
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
