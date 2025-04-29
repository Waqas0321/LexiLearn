import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../core/Const/app_colors.dart';
import '../../../../core/app_routes/routes.dart';
import '../../../../core/const/app_images.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_input_textfield.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../controller/signIn_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final SignInController controller = Get.find<SignInController>();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          child: Container(
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
              child: SafeArea(
                child: Padding(
                  padding: appSizes.getCustomPadding(top: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppImages.logo,
                        height: appSizes.getHeightPercentage(12),
                        width: appSizes.getWidthPercentage(40),
                      ),
                      const Gap(23),
                      CustomInputTextField(
                        textEditingController: controller.emailController,
                        hintText: "Enter Email",
                        labelText: "Email",
                        isValidator: true,
                        emptyValueErrorText: "Please enter your email",
                      ),
                      const Gap(16),
                      CustomInputTextField(
                        textEditingController: controller.passwordController,
                        hintText: "Enter Password",
                        labelText: "Password",
                        isObsecure: true,
                        hasSuffixIcon: true,
                        isValidator: true,
                        emptyValueErrorText: "Please enter your password",
                      ),
                      const Gap(6),
                      SizedBox(
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.FORGETPASSWORDSCREEN);
                          },
                          child: const CustomTextWidget(
                            textAlign: TextAlign.end,
                            text: "Forget Password?",
                            fontSize: 14,
                            textColor: AppColors.blackish,
                          ),
                        ),
                      ),
                      const Gap(21),
                      Obx(
                        () =>  CustomElevatedButton(
                          isLoading: controller.isLoading.value,
                          onPress: () async {
                            if (controller.passwordController.text != null) {
                              controller.userSignIn();
                            } else {
                              controller.toast.showCustomToast(
                                "Please fill all fields",
                              );
                            }
                          },
                          text: "SIGN IN",
                        ),
                      ),
                      Gap(appSizes.getHeightPercentage(2)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomTextWidget(
                            text: "Don't have any account?",
                            fontSize: 12,
                            textColor: AppColors.blackish,
                          ),
                          Gap(4),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.SIGNUPSCREEN);
                            },
                            child: const CustomTextWidget(
                              text: "Create account",
                              fontSize: 13,
                              textColor: AppColors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
