import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/utils/app_sizes.dart';
import 'package:lexi_learn/faetures/colors/controller/colors_controller.dart';
import '../../../core/Const/app_colors.dart';
import '../../../core/Const/app_images.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_text_widget.dart';
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
                  Obx(
                    () => GridView.builder(
                      shrinkWrap: true,
                      itemCount: controller.colors.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        final color = controller.colors[index];
                        return GestureDetector(
                          onTap: () {
                            controller.setIndex(index);
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
                                Icon(Icons.star, color: color.color),
                                CustomTextWidget(
                                  text: color.name,
                                  fontSize: 12,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
