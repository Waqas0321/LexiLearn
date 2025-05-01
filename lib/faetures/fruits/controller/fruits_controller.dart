import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/Const/app_images.dart';
import 'package:lexi_learn/data/models/fruit_model.dart';
import '../../../data/providers/firestore_provider.dart';

class FruitsController extends GetxController{
  FireStoreProvider fireStore = FireStoreProvider();
  final FlutterTts tts = FlutterTts();

  var fruits = <FruitModel>[
    FruitModel(name: 'Apple', imagePath: AppImages.apple),
    FruitModel(name: 'Banana', imagePath: AppImages.banana),
    FruitModel(name: 'Orange', imagePath: AppImages.orange),
    FruitModel(name: 'Grapes', imagePath: AppImages.grapes),
    FruitModel(name: 'Pineapple', imagePath: AppImages.pineapple),
    FruitModel(name: 'Mango', imagePath: AppImages.mango),
    FruitModel(name: 'Strawberry', imagePath: AppImages.strawberry),
    FruitModel(name: 'Watermelon', imagePath: AppImages.watermelon),
    FruitModel(name: 'Peach', imagePath: AppImages.peach),
    FruitModel(name: 'Pear', imagePath: AppImages.pear),
    FruitModel(name: 'Cherry', imagePath: AppImages.cherry),
    FruitModel(name: 'Blueberry', imagePath: AppImages.blueberry),
    FruitModel(name: 'Lemon', imagePath: AppImages.lemon),
    FruitModel(name: 'Papaya', imagePath: AppImages.papaya),
    FruitModel(name: 'Kiwi', imagePath: AppImages.kiwi),
    FruitModel(name: 'Plum', imagePath: AppImages.plum),
  ].obs;


  var currentIndex = 0.obs;
  void setIndex(int index) {
    currentIndex.value = index;
    speakFruit();
  }
  void next() {
    if (currentIndex < fruits.length - 1) {
      currentIndex++;
      speakFruit();
    }
  }
  void previous() {
    if (currentIndex > 0) {
      currentIndex--;
      speakFruit();
    }
  }
  void speakFruit() {
    Future.delayed(Duration(seconds: 1), () {
      tts.speak(fruits[currentIndex.value].name);
    });
  }
  void reListen() => speakFruit();

  Stream<Map<String, dynamic>?> getFruitsQuizProgress() {
    return fireStore.getDataByUserID(
      collectionName: "fruits_quiz",
      fromJson: (data) => data,
    );
  }
}