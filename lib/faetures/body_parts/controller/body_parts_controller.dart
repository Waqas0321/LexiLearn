import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/Const/app_images.dart';
import '../../../data/models/bodyparts_model.dart';
import '../../../data/providers/firestore_provider.dart';

class BodyPartsController extends GetxController{
  FireStoreProvider fireStore = FireStoreProvider();
  final FlutterTts tts = FlutterTts();

  var bodyparts = <BodypartsModel>[
    BodypartsModel(name: 'eyes', imagePath: AppImages.eyes),
    BodypartsModel(name: 'nose', imagePath: AppImages.nose),
    BodypartsModel(name: 'teeth', imagePath: AppImages.teeth),
    BodypartsModel(name: 'ear', imagePath: AppImages.ear),
    BodypartsModel(name: 'cheeks', imagePath: AppImages.cheeks),
    BodypartsModel(name: 'chin', imagePath: AppImages.chin),
    BodypartsModel(name: 'eyebrow', imagePath: AppImages.eyebrow),
    BodypartsModel(name: 'lips', imagePath: AppImages.lips),
    BodypartsModel(name: 'tongue', imagePath: AppImages.tongue),
    BodypartsModel(name: 'back', imagePath: AppImages.back),
    BodypartsModel(name: 'chest', imagePath: AppImages.chest),
    BodypartsModel(name: 'elbow', imagePath: AppImages.elbow),
    BodypartsModel(name: 'fingers', imagePath: AppImages.fingers),
    BodypartsModel(name: 'foot', imagePath: AppImages.foot),
    BodypartsModel(name: 'hand', imagePath: AppImages.hand),
    BodypartsModel(name: 'leg', imagePath: AppImages.leg),
    BodypartsModel(name: 'neck', imagePath: AppImages.neck),
    BodypartsModel(name: 'thumb', imagePath: AppImages.thumb),
    BodypartsModel(name: 'arm', imagePath: AppImages.arm),

  ].obs;


  var currentIndex = 0.obs;
  void setIndex(int index) {
    currentIndex.value = index;
    speakBodyparts();
  }
  void next() {
    if (currentIndex < bodyparts.length - 1) {
      currentIndex++;
      speakBodyparts();
    }
  }
  void previous() {
    if (currentIndex > 0) {
      currentIndex--;
      speakBodyparts();
    }
  }
  void speakBodyparts() {
    Future.delayed(Duration(seconds: 1), () {
      tts.speak(bodyparts[currentIndex.value].name);
    });
  }
  void reListen() => speakBodyparts();

  Stream<Map<String, dynamic>?> getBodypartsQuizProgress() {
    return fireStore.getDataByUserID(
      collectionName: "Body parts Quiz",
      fromJson: (data) => data,
    );
  }
}