import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/Const/app_colors.dart';
import 'package:lexi_learn/core/Const/app_images.dart';
import 'package:lexi_learn/core/utils/app_sizes.dart';
import 'package:lexi_learn/core/widgets/custom_text_widget.dart';
import 'package:lexi_learn/faetures/splash/pages/loading/controller/loading_controller.dart';

class LoadingScreen extends StatelessWidget {
  LoadingScreen({super.key});

  final LoadingController controller = Get.find<LoadingController>();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          color: AppColors.white,
          child: Center(
            child: Padding(
              padding: appSizes.getCustomPadding(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.loading),
                  Gap(20),
                  Obx(
                    () => Padding(
                      padding: appSizes.getCustomPadding(),
                      child: Column(
                        children: [
                          LinearProgressIndicator(
                            value: double.parse(
                              controller.progress.value.toStringAsFixed(2),
                            ),
                            backgroundColor: AppColors.whitish,
                            color: AppColors.orange,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          Gap(10),
                          CustomTextWidget(
                            text:
                                "${(controller.progress.value * 100).toStringAsFixed(0)}%",
                            textColor: AppColors.orange,
                            fontWeight: FontWeight.w800,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
