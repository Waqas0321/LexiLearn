import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/utils/app_sizes.dart';
import 'package:lexi_learn/faetures/body_parts/controller/body_parts_controller.dart';
import '../../../core/Const/app_images.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_text_widget.dart';

class BodyPartsScreen extends StatelessWidget {
  BodyPartsScreen({super.key});

  final BodyPartsController controller = Get.find<BodyPartsController>();
  final appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: CustomAppBar(title: "Body Parts",goBack: true),
          body: Container(
            height: appSizes.getHeightPercentage(100),
            width: appSizes.getWidthPercentage(100),
            padding: appSizes.getCustomPadding(),
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(AppImages.background),fit: BoxFit.cover)
            ),
            child: Center(
              child: CustomTextWidget(text: "Body Parts"),
            ),
          ),
        );
      },
    );
  }
}
