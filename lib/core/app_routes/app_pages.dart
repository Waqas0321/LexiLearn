import 'package:get/get.dart';
import 'package:lexi_learn/core/app_routes/routes.dart';
import '../../faetures/auth/sign_up/view/sign_up_screen.dart';
import '../../faetures/auth/signin/view/signin_screen.dart';
import '../../faetures/home/view/home_screen.dart';
import '../../faetures/splash/view/splash_screen.dart';

class AppPages {
  static final routes = [
    GetPage(
        name: AppRoutes.SPLASHSCREEN,
        page: () => SplashScreen(),
        transition: Transition.zoom,
        transitionDuration: const Duration(microseconds: 300)),
    GetPage(
        name: AppRoutes.SIGNINSCREEN,
        page: () => SignInScreen(),
        transition: Transition.zoom,
        transitionDuration: const Duration(microseconds: 300)),
    GetPage(
        name: AppRoutes.SIGNUPSCREEN,
        page: () => SignUpScreen(),
        transition: Transition.zoom,
        transitionDuration: const Duration(microseconds: 300)),
    GetPage(
        name: AppRoutes.HOMESCREEN,
        page: () => HomeScreen(),
        transition: Transition.zoom,
        transitionDuration: const Duration(microseconds: 300)),
  ];
}
