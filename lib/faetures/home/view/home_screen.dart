import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/widgets/custom_text_widget.dart';
import '../../../core/utils/app_sizes.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeController controller = Get.find();
  AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          child: Center(child: CustomTextWidget(text: "Home Screen")),
        );
      },
    );
  }
}
