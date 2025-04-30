import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/data/providers/firebase_storage.dart';
import 'package:lexi_learn/data/providers/firestore_provider.dart';
import 'package:lexi_learn/data/providers/user_provider.dart';
import '../../../../core/app_routes/routes.dart';
import '../../../../core/helpers/image_picker.dart';
import '../../../../core/widgets/custom_toast_show.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/shared_preference/shared_preference_services.dart';

class SignUpController extends GetxController {
  UserProvider auth = UserProvider();
  StorageProvider storage = StorageProvider();
  FireStoreProvider fireStore = FireStoreProvider();
  ImagePickerHelper imagePicker = ImagePickerHelper();
  ToastClass toast = ToastClass();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController createPasswordController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  File? imagePath = ImagePickerHelper().selectedImage.value;
  RxBool isLoading = false.obs;

  Future<void> userSignUp() async {
    try {
      isLoading.value = true;
      if (imagePicker.selectedImage.value != null) {
        await storage.uploadImage(imagePicker.selectedImage.value!);
      }
      await auth
          .signUp(
        emailController.text.trim(),
        createPasswordController.text.trim(),
      )
          .then((_) async {
        String? userId = await PreferenceHelper.getString("userID");

        UserModel user = UserModel(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
          userID: userId,
          imagePath: storage.imageUrl.value,
        );

        await fireStore
            .storeDataWithUserID(
          collectionName: "lexi_learn_users",
          data: user,
          toJson: (user) => user.toJson(),
        )
            .then((_) {
          refreshField();
          Get.toNamed(AppRoutes.HOMESCREEN);
        });
      });
    } catch (e) {
      log("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void refreshField() {
    imagePicker.selectedImage.value = null;
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    createPasswordController.clear();
    confirmPasswordController.clear();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    refreshField();
  }
}
