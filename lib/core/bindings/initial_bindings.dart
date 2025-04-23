import 'package:get/get.dart';
import '../../faetures/auth/sign_up/controller/signup_controller.dart';
import '../../faetures/auth/signin/controller/signIn_controller.dart';
import '../../faetures/home/controllers/home_controller.dart';
import '../../faetures/splash/controllers/splash_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.lazyPut(
      () => SplashController(),
    );

    Get.put(SignUpController());
    Get.lazyPut(
      () => SignUpController(),
    );

    Get.put(SignInController());
    Get.lazyPut(() => SignInController());

    Get.put(HomeController());
    Get.lazyPut(
      () => HomeController(),
    );

  }
}
