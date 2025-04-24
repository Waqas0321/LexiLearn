import 'package:get/get.dart';
import 'package:lexi_learn/core/Const/app_images.dart';
import 'package:lexi_learn/core/app_routes/routes.dart';
import 'package:lexi_learn/data/models/modules_model.dart';
class HomeController extends GetxController {

  final List<ModulesModel> modules = [
    ModulesModel(image: AppImages.alphabets, onPress: AppRoutes.ALPHABETSSCREEN),
    ModulesModel(image: AppImages.numbers, onPress: AppRoutes.NUMBERSSCREEN),
    ModulesModel(image: AppImages.colors, onPress: AppRoutes.COLORSSCREEN),
    ModulesModel(image: AppImages.fruits, onPress: AppRoutes.FRUITSSCREEN),
    ModulesModel(image: AppImages.ethics, onPress: AppRoutes.ETHICSSCREEN),
    ModulesModel(image: AppImages.animals, onPress: AppRoutes.ANIMALSSCREEN),
    ModulesModel(image: AppImages.bodyParts, onPress: AppRoutes.BODYPARTSSCREEN),
  ];
}
