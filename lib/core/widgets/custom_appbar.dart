import 'package:flutter/material.dart';
import '../Const/app_colors.dart';
import 'custom_text_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color foregroundColor;
  final double fontSize;
  final List<Widget>? actionsWidgets;

  const CustomAppBar({
    super.key,
    this.title = "Title Here",
    this.backgroundColor = AppColors.darkBlue,
    this.foregroundColor = AppColors.white,
    this.fontSize = 16,this.actionsWidgets,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      title: CustomTextWidget(
        text: title,
        textColor: foregroundColor,
        textAlign: TextAlign.start,
        fontSize: fontSize,
      ),
      actions: actionsWidgets,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
