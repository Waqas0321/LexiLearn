import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/Const/app_colors.dart';
import '../../../core/Const/app_images.dart';
import '../../../core/utils/app_sizes.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.find<SplashController>();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          color: AppColors.white,
          child: Container(
            height: appSizes.getHeightPercentage(100),
            width: appSizes.getWidthPercentage(100),
            padding: appSizes.getCustomPadding(),
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(AppImages.background),fit: BoxFit.cover)
            ),
            child: Center(
              child: Image.asset(
                AppImages.logo,
                height: 170,
                width: 170,
              ),
            ),
          ),
        );
      },
    );
  }
}
