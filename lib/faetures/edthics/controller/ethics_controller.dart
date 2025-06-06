import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/Const/app_images.dart';
import '../../../data/models/ethics_model.dart';
import '../../../data/providers/firestore_provider.dart';

class EthicsController extends GetxController{
  FireStoreProvider fireStore = FireStoreProvider();
  final FlutterTts tts = FlutterTts();

  var ethics = <EthicModel>[
    EthicModel(name: 'Welcome', imagePath: AppImages.welcome),
    EthicModel(name: 'Good Morning', imagePath: AppImages.goodMorning),
    EthicModel(name: 'Good Night', imagePath: AppImages.goodNight),
    EthicModel(name: 'Sorry', imagePath: AppImages.sorry),
    EthicModel(name: 'Bye', imagePath: AppImages.bye),
    EthicModel(name: 'Request', imagePath: AppImages.request),
    EthicModel(name: 'Asalam o Alaikum', imagePath: AppImages.aoa),
    EthicModel(name: 'Walaikum Asalam', imagePath: AppImages.walaikumAsalam),
    EthicModel(name: "Don't Touch", imagePath: AppImages.dontTouch),
    EthicModel(name: 'Congrats', imagePath: AppImages.congrats),
    EthicModel(name: 'Appreciate', imagePath: AppImages.appreciate),
  ].obs;


  var currentIndex = 0.obs;
  void setIndex(int index) {
    currentIndex.value = index;
    speakFruit();
  }
  void next() {
    if (currentIndex < ethics.length - 1) {
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
      tts.speak(ethics[currentIndex.value].name);
    });
  }
  void reListen() => speakFruit();

  Stream<Map<String, dynamic>?> getEthicsQuizProgress() {
    return fireStore.getDataByUserID(
      collectionName: "ethics_quiz",
      fromJson: (data) => data,
    );
  }
}