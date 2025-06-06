import 'package:get/get.dart';
import 'package:lexi_learn/faetures/ai/controller/ai_controller.dart';
import 'package:lexi_learn/faetures/alphabets/controller/alphabets_controller.dart';
import 'package:lexi_learn/faetures/alphabets/controller/alphabets_quiz_controller.dart';
import 'package:lexi_learn/faetures/animals/controller/animals_controller.dart';
import 'package:lexi_learn/faetures/animals/controller/animals_quiz_controller.dart';
import 'package:lexi_learn/faetures/auth/forget_password/controller/forget_password_controller.dart';
import 'package:lexi_learn/faetures/body_parts/controller/body_parts_controller.dart';
import 'package:lexi_learn/faetures/body_parts/controller/bodyparts_quiz_controller.dart';
import 'package:lexi_learn/faetures/colors/controller/colors_controller.dart';
import 'package:lexi_learn/faetures/colors/controller/colors_quiz_controller.dart';
import 'package:lexi_learn/faetures/edthics/controller/ethics_controller.dart';
import 'package:lexi_learn/faetures/fruits/controller/fruits_controller.dart';
import 'package:lexi_learn/faetures/fruits/controller/fruits_quiz_controller.dart';
import 'package:lexi_learn/faetures/numbers/controller/numbers_controller.dart';
import 'package:lexi_learn/faetures/numbers/controller/numbers_quiz_controller.dart';
import 'package:lexi_learn/faetures/profile/controller/profile_controller.dart';
import 'package:lexi_learn/faetures/splash/pages/loading/controller/loading_controller.dart';
import '../../faetures/auth/sign_up/controller/signup_controller.dart';
import '../../faetures/auth/signin/controller/signIn_controller.dart';
import '../../faetures/home/controllers/home_controller.dart';
import '../../faetures/splash/controllers/splash_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.lazyPut(() => SplashController(),);

    Get.put(LoadingController());
    Get.lazyPut(() => LoadingController(),);

    Get.put(ForgetPasswordController());
    Get.lazyPut(() => ForgetPasswordController(),);

    Get.put(SignUpController());
    Get.lazyPut(() => SignUpController(),);

    Get.put(SignInController());
    Get.lazyPut(() => SignInController());

    Get.put(HomeController());
    Get.lazyPut(() => HomeController());

    Get.put(AlphabetsController());
    Get.lazyPut(() => AlphabetsController());

    Get.put(NumbersController());
    Get.lazyPut(() => NumbersController());

    Get.put(ColorsController());
    Get.lazyPut(() => NumbersController());

    Get.put(FruitsController());
    Get.lazyPut(() => FruitsController());

    Get.put(EthicsController());
    Get.lazyPut(() => EthicsController());

    Get.put(AnimalsController());
    Get.lazyPut(() => AnimalsController());

    Get.put(BodyPartsController());
    Get.lazyPut(() => BodyPartsController());

    Get.put(ProfileController());
    Get.lazyPut(() => ProfileController());

    Get.put(ColorsQuizController());
    Get.lazyPut(() => ColorsQuizController());

    Get.put(FruitsQuizController());
    Get.lazyPut(() => FruitsQuizController());

    Get.put(AnimalsQuizController());
    Get.lazyPut(() => AnimalsQuizController());

    Get.put(AiChatController());
    Get.lazyPut(() => AiChatController());

    Get.put(AlphabetsQuizController());
    Get.lazyPut(() => AlphabetsQuizController());


    Get.put(BodypartsQuizController());
    Get.lazyPut(() => BodypartsQuizController());

    Get.put(NumbersController());
    Get.lazyPut(() => NumbersController());

    Get.put(NumbersQuizController());
    Get.lazyPut(() => NumbersQuizController());

  }
}
