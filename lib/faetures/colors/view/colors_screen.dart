import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/utils/app_sizes.dart';
import 'package:lexi_learn/faetures/colors/controller/colors_controller.dart';
import '../../../core/Const/app_images.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_text_widget.dart';

class ColorsScreen extends StatelessWidget {
  ColorsScreen({super.key});

  final ColorsController controller = Get.find<ColorsController>();
  final appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: CustomAppBar(title: "Colors",goBack: true),
          body: Container(
            height: appSizes.getHeightPercentage(100),
            width: appSizes.getWidthPercentage(100),
            padding: appSizes.getCustomPadding(),
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(AppImages.background),fit: BoxFit.cover)
            ),
            child: Center(
              child: CustomTextWidget(text: "Colors"),
            ),
          ),
        );
      },
    );
  }
}
