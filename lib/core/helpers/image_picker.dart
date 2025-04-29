import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lexi_learn/core/utils/app_sizes.dart';
import 'package:lexi_learn/core/widgets/custom_elevated_button.dart';
import '../../core/Const/app_colors.dart';
import '../../core/widgets/custom_text_widget.dart';

class ImagePickerHelper {
  AppSizes appSizes = AppSizes();
  final Rx<File?> selectedImage = Rx<File?>(null);

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
    Get.back();
  }

  void showImagePickerDialog() {
    final RxnString selectedSource = RxnString('gallery');
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColors.darkGreen,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: appSizes.getCustomPadding(),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomTextWidget(
                  text: "Choose Image Source",
                  textColor: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                const Gap(34),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => selectedSource.value = 'gallery',
                        child: Container(
                          height: 170,
                          padding: appSizes.getCustomPadding(),
                          decoration: BoxDecoration(
                            color:
                                selectedSource.value == 'gallery'
                                    ? AppColors.orange
                                    : AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: selectedSource.value == 'gallery'
                                      ? AppColors.orange
                                      : AppColors.white,
                                  blurRadius: 8,
                                  spreadRadius: 1
                              )
                            ]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo_library,
                                size: 70,
                                color:
                                    selectedSource.value == 'gallery'
                                        ? AppColors.white
                                        : AppColors.darkGreen,
                              ),
                              Gap(12),
                              CustomTextWidget(
                                text: "Gallery",
                                fontWeight: FontWeight.w600,
                                textColor:
                                    selectedSource.value == 'gallery'
                                        ? AppColors.white
                                        : AppColors.darkGreen,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(18),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => selectedSource.value = 'camera',
                        child: Container(
                          height: 170,
                          padding: appSizes.getCustomPadding(),
                          decoration: BoxDecoration(
                            color:
                                selectedSource.value == 'camera'
                                    ? AppColors.orange
                                    : AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: selectedSource.value == 'camera'
                                    ? AppColors.orange
                                    : AppColors.white,
                                blurRadius: 8,
                                spreadRadius: 1
                              )
                            ]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera,
                                size: 70,
                                color:
                                    selectedSource.value == 'camera'
                                        ? AppColors.white
                                        : AppColors.darkGreen,
                              ),
                              Gap(12),
                              CustomTextWidget(
                                text: "Camera",
                                fontWeight: FontWeight.w600,
                                textColor:
                                    selectedSource.value == 'camera'
                                        ? AppColors.white
                                        : AppColors.darkGreen,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(34),
                CustomElevatedButton(
                  borderRadius: 44,
                  onPress: () {
                    if (selectedSource.value != null) {
                      pickImage(
                        selectedSource.value == 'gallery'
                            ? ImageSource.gallery
                            : ImageSource.camera,
                      );
                    }
                  },
                  text: "Continue",
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  void clearImage() {
    selectedImage.value = null;
  }
}
