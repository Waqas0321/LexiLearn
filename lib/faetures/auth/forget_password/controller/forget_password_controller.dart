import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/data/providers/user_provider.dart';
import '../../../../core/widgets/custom_toast_show.dart';

class ForgetPasswordController extends GetxController{
  UserProvider auth = UserProvider();
  final ToastClass toast = ToastClass();
  TextEditingController emailController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> resetPassword() async{
    try{
      isLoading.value = true;
      await auth.resetPassword(emailController.text.trim()).then((value) {
        emailController.clear();
        return Get.back();
      });
    }catch(e){
      log("Exception : $e");
    }finally{
      isLoading.value = false;
    }
  }


  @override
  void dispose() {
    super.dispose();
    emailController.clear();
  }

}