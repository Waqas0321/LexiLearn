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
import '../controller/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpController controller = Get.find<SignUpController>();
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
            child: SafeArea(
              child: Form(
                key: controller.formKey,
                child: Padding(
                  padding: appSizes.getCustomPadding(top: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.logo,
                        height: appSizes.getHeightPercentage(12),
                        width: appSizes.getWidthPercentage(40),
                      ),
                      Gap(28),
                      Row(
                        children: [
                          Expanded(
                            child: CustomInputTextField(
                              textEditingController:
                                  controller.firstNameController,
                              hintText: "Enter First Name",
                              labelText: "First Name",
                              isValidator: true,
                              emptyValueErrorText: "Please enter first name",
                            ),
                          ),
                          const Gap(16),
                          Expanded(
                            child: CustomInputTextField(
                              textEditingController:
                                  controller.lastNameController,
                              hintText: "Enter Last Name",
                              labelText: "Last Name",
                              isValidator: true,
                              emptyValueErrorText: "Please enter last name",
                            ),
                          ),
                        ],
                      ),
                      const Gap(16),
                      CustomInputTextField(
                        textEditingController: controller.emailController,
                        hintText: "Enter Email",
                        labelText: "Email",
                        isValidator: true,
                        emptyValueErrorText: "Please enter your email",
                      ),
                      const Gap(16),
                      CustomInputTextField(
                        textEditingController:
                            controller.createPasswordController,
                        hintText: "Create your Password",
                        labelText: "Create Password",
                        hasSuffixIcon: true,
                        isObsecure: true,
                        isValidator: true,
                        emptyValueErrorText: "Please create password",
                      ),
                      const Gap(16),
                      CustomInputTextField(
                        textEditingController:
                            controller.confirmPasswordController,
                        hintText: "Confirm your Password",
                        labelText: "Confirm Password",
                        hasSuffixIcon: true,
                        isObsecure: true,
                        isValidator: true,
                        emptyValueErrorText: "Please enter confirm password",
                      ),
                      const Gap(21),
                      Obx(
                       () =>  CustomElevatedButton(
                          isLoading: controller.isLoading.value,
                          onPress: () {
                            if (controller.formKey.currentState!.validate()) {
                              if (controller.createPasswordController.text ==
                                  controller.confirmPasswordController.text) {
                                controller.userSignUp();
                              } else {
                                controller.toast.showCustomToast(
                                  "Passwords mismatch",
                                );
                              }
                            } else {
                              controller.toast.showCustomToast(
                                "Please fill all fields",
                              );
                            }
                          },
                          text: "SIGN UP",
                        ),
                      ),
                      Gap(appSizes.getHeightPercentage(3)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomTextWidget(
                            text: "Already have an account?",
                            fontSize: 12,
                            textColor: AppColors.blackish,
                          ),
                          Gap(4),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.SIGNINSCREEN);
                            },
                            child: CustomTextWidget(
                              text: "Sign In",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
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
