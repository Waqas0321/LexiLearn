import 'package:flutter/material.dart';
import '../Const/app_colors.dart';
import 'custom_text_widget.dart';

class CustomDraggableTile extends StatelessWidget {
  final String text;

  const CustomDraggableTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.brown),
      ),
      child: CustomTextWidget(
        text: text,
        fontSize: 16,
        textColor: AppColors.black,
      ),
    );
  }
}
