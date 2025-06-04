import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/data/models/alphabet_model.dart';
import '../../../core/Const/app_images.dart';
import '../../../data/providers/firestore_provider.dart';

class AlphabetsController extends GetxController{
  FireStoreProvider fireStore = FireStoreProvider();
  final FlutterTts tts = FlutterTts();

  var alphabet = <AlphabetModel>[

    AlphabetModel(name: 'A', imagePath: AppImages.A),
    AlphabetModel(name: 'B', imagePath: AppImages.B),
    AlphabetModel(name: 'C', imagePath: AppImages.C),
    AlphabetModel(name: 'D', imagePath: AppImages.D),
    AlphabetModel(name: 'E', imagePath: AppImages.E),
    AlphabetModel(name: 'F', imagePath: AppImages.F),
    AlphabetModel(name: 'G', imagePath: AppImages.G),
    AlphabetModel(name: 'H', imagePath: AppImages.H),
    AlphabetModel(name: 'I', imagePath: AppImages.I),
    AlphabetModel(name: 'J', imagePath: AppImages.J),
    AlphabetModel(name: 'K', imagePath: AppImages.K),
    AlphabetModel(name: 'L', imagePath: AppImages.L),
    AlphabetModel(name: 'M', imagePath: AppImages.M),
    AlphabetModel(name: 'N', imagePath: AppImages.N),
    AlphabetModel(name: 'O', imagePath: AppImages.O),
    AlphabetModel(name: 'P', imagePath: AppImages.P),
    AlphabetModel(name: 'Q', imagePath: AppImages.Q),
    AlphabetModel(name: 'R', imagePath: AppImages.R),
    AlphabetModel(name: 'S', imagePath: AppImages.S),
    AlphabetModel(name: 'T', imagePath: AppImages.T),
    AlphabetModel(name: 'U', imagePath: AppImages.U),
    AlphabetModel(name: 'V', imagePath: AppImages.V),
    AlphabetModel(name: 'W', imagePath: AppImages.W),
    AlphabetModel(name: 'X', imagePath: AppImages.X),
    AlphabetModel(name: 'Y', imagePath: AppImages.Y),
    AlphabetModel(name: 'Z', imagePath: AppImages.Z),



  ].obs;

  var currentIndex = 0.obs;
  void setIndex(int index) {
    currentIndex.value = index;
    speakAlphabet();
  }
  void next() {
    if (currentIndex < alphabet.length - 1) {
      currentIndex++;
      speakAlphabet();
    }
  }
  void previous() {
    if (currentIndex > 0) {
      currentIndex--;
      speakAlphabet();
    }
  }
  void speakAlphabet() {
    Future.delayed(Duration(seconds: 1), () {
      tts.speak(alphabet[currentIndex.value].name);
    });
  }
  void reListen() => speakAlphabet();

  Stream<Map<String, dynamic>?> getAlphabetsQuizProgress() {
    return fireStore.getDataByUserID(
      collectionName: "Alphabets_Quiz",
      fromJson: (data) => data,
    );
  }
}
