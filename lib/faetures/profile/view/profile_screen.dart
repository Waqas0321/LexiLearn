import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lexi_learn/core/Const/app_colors.dart';
import 'package:lexi_learn/core/utils/app_sizes.dart';
import 'package:lexi_learn/core/widgets/custom_elevated_button.dart';
import 'package:lexi_learn/data/models/user_model.dart';
import 'package:lexi_learn/faetures/profile/controller/profile_controller.dart';
import 'package:get/get.dart';
import '../../../core/Const/app_images.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_text_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  ProfileController controller = Get.find<ProfileController>();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: CustomAppBar(title: "Profile", goBack: true),
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
            child: StreamBuilder(
              stream: controller.getUserStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(color: AppColors.orange)),
                  );
                } else if (snapshot.hasData) {
                  UserModel? user = snapshot.data;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TweenAnimationBuilder<double>(
                        duration: Duration(milliseconds: 800),
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value.clamp(0.0, 1.0),
                            child: child,
                          );
                        },
                        child: Container(
                          padding: appSizes.getCustomPadding(),
                          margin: appSizes.getCustomPadding(),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.blackish,
                                blurRadius: 16,
                                spreadRadius: -1,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: appSizes.getCustomPadding(
                                  top: 1.2,
                                  left: 1.2,
                                  right: 1.2,
                                  bottom: 1.2,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.orange,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.blackish,
                                      blurRadius: 10,
                                      spreadRadius: -1,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundImage: NetworkImage(
                                    user!.imagePath!,
                                  ),
                                ),
                              ),
                              Gap(26),
                              CustomTextWidget(
                                text: "${user.firstName} ${user.lastName}",
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.green,
                              ),
                              Gap(2),
                              CustomTextWidget(
                                text: user.email,
                                fontSize: 16,
                                textColor: AppColors.blackish,
                              ),
                              Gap(36),
                              CustomElevatedButton(
                                backgroundColor: AppColors.red,
                                onPress: () {
                                  controller.auth.signOut();
                                },
                                text: "Logout",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Center(child: CustomTextWidget(text: "User not found"));
              },
            ),
          ),
        );
      },
    );
  }
}
