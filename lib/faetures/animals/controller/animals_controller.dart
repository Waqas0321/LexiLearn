import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import '../../../core/Const/app_images.dart';
import '../../../data/models/fruit_model.dart';
import '../../../data/providers/firestore_provider.dart';

class AnimalsController extends GetxController{
  FireStoreProvider fireStore = FireStoreProvider();
  final FlutterTts tts = FlutterTts();

  var animals = <FruitModel>[
    FruitModel(name: 'Cat', imagePath: AppImages.cat),           // Home animal
    FruitModel(name: 'Sheep', imagePath: AppImages.sheep),        // Home animal
    FruitModel(name: 'Cow', imagePath: AppImages.cow),          // Home animal
    FruitModel(name: 'Goat', imagePath: AppImages.goat),
    FruitModel(name: 'Lion', imagePath: AppImages.lion),
    FruitModel(name: 'Tiger', imagePath: AppImages.tiger),
    FruitModel(name: 'Elephant', imagePath: AppImages.elephant),
    FruitModel(name: 'Giraffe', imagePath: AppImages.giraffe),
    FruitModel(name: 'Zebra', imagePath: AppImages.zebra),
    FruitModel(name: 'Monkey', imagePath: AppImages.monkey),
    FruitModel(name: 'Kangaroo', imagePath: AppImages.kangaroo),
    FruitModel(name: 'Panda', imagePath: AppImages.panda),
    FruitModel(name: 'Bear', imagePath: AppImages.bear),
    FruitModel(name: 'Wolf', imagePath: AppImages.wolf),
    FruitModel(name: 'Fox', imagePath: AppImages.fox),
    FruitModel(name: 'Rabbit', imagePath: AppImages.rabbit),
    FruitModel(name: 'Deer', imagePath: AppImages.deer),
    FruitModel(name: 'Dog', imagePath: AppImages.dog),
    FruitModel(name: 'Horse', imagePath: AppImages.horse),
    FruitModel(name: 'Leopard', imagePath: AppImages.leopard),
  ].obs;

  var currentIndex = 0.obs;
  void setIndex(int index) {
    currentIndex.value = index;
    speakAnimal();
  }
  void next() {
    if (currentIndex < animals.length - 1) {
      currentIndex++;
      speakAnimal();
    }
  }
  void previous() {
    if (currentIndex > 0) {
      currentIndex--;
      speakAnimal();
    }
  }
  void speakAnimal() {
    Future.delayed(Duration(seconds: 1), () {
      tts.speak(animals[currentIndex.value].name);
    });
  }
  void reListen() => speakAnimal();

  Stream<Map<String, dynamic>?> getFruitsQuizProgress() {
    return fireStore.getDataByUserID(
      collectionName: "animals_quiz",
      fromJson: (data) => data,
    );
  }
}