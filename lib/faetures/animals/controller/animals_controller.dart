import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import '../../../core/Const/app_images.dart';
import '../../../data/models/animals_model.dart';
import '../../../data/providers/firestore_provider.dart';

class AnimalsController extends GetxController{
  FireStoreProvider fireStore = FireStoreProvider();
  final FlutterTts tts = FlutterTts();

  var animals = <AnimalsModel>[
    AnimalsModel(name: 'Cat', imagePath: AppImages.cat),
    AnimalsModel(name: 'Sheep', imagePath: AppImages.sheep),
    AnimalsModel(name: 'Cow', imagePath: AppImages.cow),
    AnimalsModel(name: 'Goat', imagePath: AppImages.goat),
    AnimalsModel(name: 'Lion', imagePath: AppImages.lion),
    AnimalsModel(name: 'Tiger', imagePath: AppImages.tiger),
    AnimalsModel(name: 'Elephant', imagePath: AppImages.elephant),
    AnimalsModel(name: 'Giraffe', imagePath: AppImages.giraffe),
    AnimalsModel(name: 'Zebra', imagePath: AppImages.zebra),
    AnimalsModel(name: 'Monkey', imagePath: AppImages.monkey),
    AnimalsModel(name: 'Kangaroo', imagePath: AppImages.kangaroo),
    AnimalsModel(name: 'Panda', imagePath: AppImages.panda),
    AnimalsModel(name: 'Bear', imagePath: AppImages.bear),
    AnimalsModel(name: 'Wolf', imagePath: AppImages.wolf),
    AnimalsModel(name: 'Fox', imagePath: AppImages.fox),
    AnimalsModel(name: 'Rabbit', imagePath: AppImages.rabbit),
    AnimalsModel(name: 'Deer', imagePath: AppImages.deer),
    AnimalsModel(name: 'Dog', imagePath: AppImages.dog),
    AnimalsModel(name: 'Horse', imagePath: AppImages.horse),
    AnimalsModel(name: 'Leopard', imagePath: AppImages.leopard),
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