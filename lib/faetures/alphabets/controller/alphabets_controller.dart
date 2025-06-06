import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/data/models/alphabet_model.dart';
import '../../../core/Const/app_images.dart';
import '../../../data/providers/firestore_provider.dart';

class AlphabetsController extends GetxController {
  FireStoreProvider fireStore = FireStoreProvider();
  final FlutterTts tts = FlutterTts();

  var alphabet =
      <AlphabetModel>[
        AlphabetModel(
          name: 'A',
          imagePath: AppImages.A,
          referenceText: "Aeroplane",
          referenceImagePath: AppImages.aeroplane,
        ),
        AlphabetModel(
          name: 'B',
          imagePath: AppImages.B,
          referenceText: "Ball",
          referenceImagePath: AppImages.ball,
        ),
        AlphabetModel(
          name: 'C',
          imagePath: AppImages.C,
          referenceText: "Cat",
          referenceImagePath: AppImages.cat,
        ),
        AlphabetModel(
          name: 'D',
          imagePath: AppImages.D,
          referenceText: "Dog",
          referenceImagePath: AppImages.dog,
        ),
        AlphabetModel(
          name: 'E',
          imagePath: AppImages.E,
          referenceText: "Elephant",
          referenceImagePath: AppImages.elephant,
        ),
        AlphabetModel(
          name: 'F',
          imagePath: AppImages.F,
          referenceText: "Fish",
          referenceImagePath: AppImages.fish,
        ),
        AlphabetModel(
          name: 'G',
          imagePath: AppImages.G,
          referenceText: "Giraffe",
          referenceImagePath: AppImages.giraffe,
        ),
        AlphabetModel(
          name: 'H',
          imagePath: AppImages.H,
          referenceText: "Horse",
          referenceImagePath: AppImages.horse,
        ),
        AlphabetModel(
          name: 'I',
          imagePath: AppImages.I,
          referenceText: "IceCream",
          referenceImagePath: AppImages.ice_cream,
        ),
        AlphabetModel(
          name: 'J',
          imagePath: AppImages.J,
          referenceText: "juice",
          referenceImagePath: AppImages.juice,
        ),
        AlphabetModel(
          name: 'K',
          imagePath: AppImages.K,
          referenceText: "Key Chain",
          referenceImagePath: AppImages.keyChain,
        ),
        AlphabetModel(
          name: 'L',
          imagePath: AppImages.L,
          referenceText: "Lion",
          referenceImagePath: AppImages.lion,
        ),
        AlphabetModel(
          name: 'M',
          imagePath: AppImages.M,
          referenceText: "Mango",
          referenceImagePath: AppImages.mango,
        ),
        AlphabetModel(
          name: 'N',
          imagePath: AppImages.N,
          referenceText: "Nest",
          referenceImagePath: AppImages.nest,
        ),
        AlphabetModel(
          name: 'O',
          imagePath: AppImages.O,
          referenceText: "Orange",
          referenceImagePath: AppImages.orange,
        ),
        AlphabetModel(
          name: 'P',
          imagePath: AppImages.P,
          referenceText: "Parrot",
          referenceImagePath: AppImages.parrot,
        ),
        AlphabetModel(
          name: 'Q',
          imagePath: AppImages.Q,
          referenceText: "Quilt",
          referenceImagePath: AppImages.quilt,
        ),
        AlphabetModel(
          name: 'R',
          imagePath: AppImages.R,
          referenceText: "Rose",
          referenceImagePath: AppImages.rose,
        ),
        AlphabetModel(
          name: 'S',
          imagePath: AppImages.S,
          referenceText: "Sun",
          referenceImagePath: AppImages.sun,
        ),
        AlphabetModel(
          name: 'T',
          imagePath: AppImages.T,
          referenceText: "Tree",
          referenceImagePath: AppImages.tree,
        ),
        AlphabetModel(
          name: 'U',
          imagePath: AppImages.U,
          referenceText: "Umbrella",
          referenceImagePath: AppImages.umbrella,
        ),
        AlphabetModel(
          name: 'V',
          imagePath: AppImages.V,
          referenceText: "Van",
          referenceImagePath: AppImages.van,
        ),
        AlphabetModel(
          name: 'W',
          imagePath: AppImages.W,
          referenceText: "Water",
          referenceImagePath: AppImages.water,
        ),
        AlphabetModel(
          name: 'X',
          imagePath: AppImages.X,
          referenceText: "XRay",
          referenceImagePath: AppImages.xRay,
        ),
        AlphabetModel(
          name: 'Y',
          imagePath: AppImages.Y,
          referenceText: "Yoyo",
          referenceImagePath: AppImages.yoyo,
        ),
        AlphabetModel(
          name: 'Z',
          imagePath: AppImages.Z,
          referenceText: "Zebra",
          referenceImagePath: AppImages.zebra,
        ),
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
    Future.delayed(Duration(seconds: 2), () async {
      await tts.setSpeechRate(0.4340);
      tts.speak(
        "${alphabet[currentIndex.value].name} for ${alphabet[currentIndex.value].referenceText}",
      );
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
