import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import '../../../core/Const/app_images.dart';
import '../../../data/models/counting_model.dart';
import '../../../data/providers/firestore_provider.dart';

class NumbersController extends GetxController {
  FireStoreProvider fireStore = FireStoreProvider();
  final FlutterTts tts = FlutterTts();

  var numbers =
      <CountingModel>[
        CountingModel(
          name: 'One',
          imagePath: AppImages.one,
          referenceImagePath: AppImages.onePic,
        ),
        CountingModel(
          name: 'Two',
          imagePath: AppImages.two,
          referenceImagePath: AppImages.twoPic,
        ),
        CountingModel(
          name: 'Three',
          imagePath: AppImages.three,
          referenceImagePath: AppImages.threePic,
        ),
        CountingModel(
          name: 'Four',
          imagePath: AppImages.four,
          referenceImagePath: AppImages.fourPic,
        ),
        CountingModel(
          name: 'Five',
          imagePath: AppImages.five,
          referenceImagePath: AppImages.fivePic,
        ),
        CountingModel(
          name: 'Six',
          imagePath: AppImages.six,
          referenceImagePath: AppImages.sixPic,
        ),
        CountingModel(
          name: 'Seven',
          imagePath: AppImages.seven,
          referenceImagePath: AppImages.sevenPic,
        ),
        CountingModel(
          name: 'Eight',
          imagePath: AppImages.eight,
          referenceImagePath: AppImages.eightPic,
        ),
        CountingModel(
          name: 'Nine',
          imagePath: AppImages.nine,
          referenceImagePath: AppImages.ninePic,
        ),
        CountingModel(
          name: 'Ten',
          imagePath: AppImages.ten,
          referenceImagePath: AppImages.tenPic,
        ),
        CountingModel(
          name: 'Eleven',
          imagePath: AppImages.eleven,
          referenceImagePath: AppImages.elevenPic,
        ),
        CountingModel(
          name: 'Twelve',
          imagePath: AppImages.twelve,
          referenceImagePath: AppImages.twelvePic,
        ),
        CountingModel(
          name: 'Thirteen',
          imagePath: AppImages.thirteen,
          referenceImagePath: AppImages.thirteenPic,
        ),
        CountingModel(
          name: 'Fourteen',
          imagePath: AppImages.fourteen,
          referenceImagePath: AppImages.fourteenPic,
        ),
        CountingModel(
          name: 'Fifteen',
          imagePath: AppImages.fifteen,
          referenceImagePath: AppImages.fifteenPic,
        ),
        CountingModel(
          name: 'Sixteen',
          imagePath: AppImages.sixteen,
          referenceImagePath: AppImages.sixteenPic,
        ),
        CountingModel(
          name: 'Seventeen',
          imagePath: AppImages.seventeen,
          referenceImagePath: AppImages.seventeenPic,
        ),
        CountingModel(
          name: 'Eighteen',
          imagePath: AppImages.eighteen,
          referenceImagePath: AppImages.eighteenPic,
        ),
        CountingModel(
          name: 'Nineteen',
          imagePath: AppImages.nineteen,
          referenceImagePath: AppImages.nineteenPic,
        ),
        CountingModel(
          name: 'Twenty',
          imagePath: AppImages.twenty,
          referenceImagePath: AppImages.twentyPic,
        ),
      ].obs;

  var currentIndex = 0.obs;

  void setIndex(int index) {
    currentIndex.value = index;
    speakNumber();
  }

  void next() {
    if (currentIndex < numbers.length - 1) {
      currentIndex++;
      speakNumber();
    }
  }

  void previous() {
    if (currentIndex > 0) {
      currentIndex--;
      speakNumber();
    }
  }

  void speakNumber() {
    Future.delayed(Duration(seconds: 1), ()async {
      await tts.setSpeechRate(0.4340);
      tts.speak(numbers[currentIndex.value].name);
    });
  }
  void reListen() => speakNumber();

  Stream<Map<String, dynamic>?> getAllCountingQuizProgress() {
    return fireStore.getDataByUserID(
      collectionName: "Numbers_Quiz",
      fromJson: (data) => data,
    );
  }
}
