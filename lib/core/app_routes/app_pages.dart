import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/app_routes/routes.dart';
import 'package:lexi_learn/faetures/ai/view/ai_screen.dart';
import 'package:lexi_learn/faetures/alphabets/tracing/view/tracing_screen.dart';
import 'package:lexi_learn/faetures/alphabets/view/alphabet_detail_screen.dart';
import 'package:lexi_learn/faetures/alphabets/view/alphabets_quiz_screen.dart';
import 'package:lexi_learn/faetures/alphabets/view/alphabets_screen.dart';
import 'package:lexi_learn/faetures/animals/view/animals_quiz_screen.dart';
import 'package:lexi_learn/faetures/animals/view/animals_screen.dart';
import 'package:lexi_learn/faetures/auth/forget_password/view/forget_password_screen.dart';
import 'package:lexi_learn/faetures/body_parts/view/body_parts_screen.dart';
import 'package:lexi_learn/faetures/body_parts/view/bodyparts_detail_screen.dart';
import 'package:lexi_learn/faetures/body_parts/view/bodyparts_quiz_screen.dart';
import 'package:lexi_learn/faetures/colors/view/colors_screen.dart';
import 'package:lexi_learn/faetures/colors/view/colors_quiz_screen.dart';
import 'package:lexi_learn/faetures/edthics/view/ethics_quiz_screen.dart';
import 'package:lexi_learn/faetures/edthics/view/ethics_screen.dart';
import 'package:lexi_learn/faetures/fruits/view/fruits_quiz_screen.dart';
import 'package:lexi_learn/faetures/fruits/view/fruits_screen.dart';
import 'package:lexi_learn/faetures/numbers/view/numbers_quiz_screen.dart';
import 'package:lexi_learn/faetures/numbers/view/numbers_screen.dart';
import 'package:lexi_learn/faetures/profile/view/profile_screen.dart';
import 'package:lexi_learn/faetures/splash/pages/loading/view/loading_screen.dart';
import '../../faetures/auth/sign_up/view/sign_up_screen.dart';
import '../../faetures/auth/signin/view/signin_screen.dart';
import '../../faetures/home/view/home_screen.dart';
import '../../faetures/splash/view/splash_screen.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.SPLASHSCREEN,
      page: () => SplashScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.SIGNINSCREEN,
      page: () => SignInScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.SIGNUPSCREEN,
      page: () => SignUpScreen(),
      transition: Transition.zoom,
      transitionDuration: const Duration(microseconds: 300),
    ),
    GetPage(
      name: AppRoutes.HOMESCREEN,
      page: () => HomeScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.LOADINGSCREEN,
      page: () => LoadingScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 140),
    ),
    GetPage(
      name: AppRoutes.FORGETPASSWORDSCREEN,
      page: () => ForgetPasswordScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),

    GetPage(
      name: AppRoutes.ALPHABETSSCREEN,
      page: () => AlphabetsScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.NUMBERSSCREEN,
      page: () => NumbersScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.NUMBERSQUIZSCREEN,
      page: () => NumbersQuizScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.ETHICSQUIZSCREEN,
      page: () => EthicsQuizScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.COLORSSCREEN,
      page: () => ColorsScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.FRUITSSCREEN,
      page: () => FruitsScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.ETHICSSCREEN,
      page: () => EthicsScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.ANIMALSSCREEN,
      page: () => AnimalsScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.BODYPARTSSCREEN,
      page: () => BodyPartsScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.PROFILESCREEN,
      page: () => ProfileScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.COLORSQUIZSCREEN,
      page: () => ColorsQuizScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.FRUITSQUIZSCREEN,
      page: () => FruitsQuizScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.ANIMALSQUIZSCREEN,
      page: () => AnimalsQuizScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.AICHATSCREEN,
      page: () => AiChatScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),

    GetPage(
      name: AppRoutes.AICHATSCREEN,
      page: () => AlphabetDetailScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),

    GetPage(
      name: AppRoutes.ALPHABETSQUIZSCREEN,
      page: () => AlphabetsQuizScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),

    GetPage(
      name: AppRoutes.ALPHABETSQUIZSCREEN,
      page: () => AlphabetsQuizScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),

    GetPage(
      name: AppRoutes.BODYPARTSDETAILSCREEN,
      page: () => BodypartsDetailScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),

    GetPage(
      name: AppRoutes.BODYPARTSQUIZSCREEN,
      page: () => BodypartsQuizScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),

    GetPage(
      name: AppRoutes.TRACEALPHABETSSCREEN,
      page: () => AlphabetTraceScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
  ];
}
