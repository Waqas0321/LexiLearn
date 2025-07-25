import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/Const/app_colors.dart';
import 'package:lexi_learn/core/Const/app_images.dart';
import 'package:lexi_learn/core/app_routes/routes.dart';
import 'package:lexi_learn/core/widgets/custom_appbar.dart';
import 'package:lexi_learn/data/models/modules_model.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/widgets/custom_container.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeController controller = Get.find();
  AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: CustomAppBar(
            actionsWidgets: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.PROFILESCREEN);
                },
                child: CircleAvatar(
                  backgroundColor: AppColors.whitish,
                  backgroundImage: AssetImage(AppImages.logo),
                ),
              ),
              Gap(12),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.white,
            onPressed: () {
              Get.toNamed(AppRoutes.AICHATSCREEN);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(AppImages.ai),
            ),
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
              child: Padding(
                padding: appSizes.getCustomPadding(),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: controller.modules.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                  ),
                  itemBuilder: (context, index) {
                    ModulesModel module = controller.modules[index];
                    return CustomContainer(
                      imagePath: module.image,
                      screenPath: module.onPress,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
