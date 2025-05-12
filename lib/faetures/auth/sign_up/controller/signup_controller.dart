import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/data/providers/firebase_storage.dart';
import 'package:lexi_learn/data/providers/firestore_provider.dart';
import 'package:lexi_learn/data/providers/user_provider.dart';
import '../../../../core/app_routes/routes.dart';
import '../../../../core/widgets/custom_toast_show.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/shared_preference/shared_preference_services.dart';

class SignUpController extends GetxController {
  UserProvider auth = UserProvider();
  StorageProvider storage = StorageProvider();
  FireStoreProvider fireStore = FireStoreProvider();
  ToastClass toast = ToastClass();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController createPasswordController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> userSignUp() async {
    try {
      isLoading.value = true;
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
