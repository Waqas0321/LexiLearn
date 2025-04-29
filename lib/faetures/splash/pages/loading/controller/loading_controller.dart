import 'dart:async';
import 'package:get/get.dart';
import '../../../../../core/app_routes/routes.dart';
import '../../../../../data/shared_preference/shared_preference_services.dart';

class LoadingController extends GetxController{
  var progress = 0.0.obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    startLoading();
  }

  void startLoading(){
    timer = Timer.periodic(const Duration(milliseconds: 80), (timer) async {
      if (progress.value < 1.0) {
        progress.value += 0.01;
      } else {
        timer.cancel();
        String? userId = await PreferenceHelper.getString("userID");
        if (userId == null || userId.isEmpty) {
          Get.offAllNamed(AppRoutes.SIGNINSCREEN);
        } else {
          Get.offAllNamed(AppRoutes.HOMESCREEN);
        }
      }
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

}