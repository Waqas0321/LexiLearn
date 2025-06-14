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
          number: '1',
          imagePath: AppImages.one,
          referenceImagePath: AppImages.onePic,
        ),
        CountingModel(
          name: 'Two',
          number: '2',
          imagePath: AppImages.two,
          referenceImagePath: AppImages.twoPic,
        ),
        CountingModel(
          name: 'Three',
          number: '3',
          imagePath: AppImages.three,
          referenceImagePath: AppImages.threePic,
        ),
        CountingModel(
          number: '4',
          name: 'Four',
          imagePath: AppImages.four,
          referenceImagePath: AppImages.fourPic,
        ),
        CountingModel(
          name: 'Five',
          number: '5',
          imagePath: AppImages.five,
          referenceImagePath: AppImages.fivePic,
        ),
        CountingModel(
          name: 'Six',
          number: '6',
          imagePath: AppImages.six,
          referenceImagePath: AppImages.sixPic,
        ),
        CountingModel(
          name: 'Seven',
          number: '7',
          imagePath: AppImages.seven,
          referenceImagePath: AppImages.sevenPic,
        ),
        CountingModel(
          name: 'Eight',
          number: '8',
          imagePath: AppImages.eight,
          referenceImagePath: AppImages.eightPic,
        ),
        CountingModel(
          name: 'Nine',
          number: '9',
          imagePath: AppImages.nine,
          referenceImagePath: AppImages.ninePic,
        ),
        CountingModel(
          name: 'Ten',
          number: '10',
          imagePath: AppImages.ten,
          referenceImagePath: AppImages.tenPic,
        ),
        CountingModel(
          name: 'Eleven',
          number: '11',
          imagePath: AppImages.eleven,
          referenceImagePath: AppImages.elevenPic,
        ),
        CountingModel(
          name: 'Twelve',
          number: '12',
          imagePath: AppImages.twelve,
          referenceImagePath: AppImages.twelvePic,
        ),
        CountingModel(
          name: 'Thirteen',
          number: '13',
          imagePath: AppImages.thirteen,
          referenceImagePath: AppImages.thirteenPic,
        ),
        CountingModel(
          name: 'Fourteen',
          number: '14',
          imagePath: AppImages.fourteen,
          referenceImagePath: AppImages.fourteenPic,
        ),
        CountingModel(
          name: 'Fifteen',
          number: '15',
          imagePath: AppImages.fifteen,
          referenceImagePath: AppImages.fifteenPic,
        ),
        CountingModel(
          name: 'Sixteen',
          number: '16',
          imagePath: AppImages.sixteen,
          referenceImagePath: AppImages.sixteenPic,
        ),
        CountingModel(
          name: 'Seventeen',
          number: '17',
          imagePath: AppImages.seventeen,
          referenceImagePath: AppImages.seventeenPic,
        ),
        CountingModel(
          name: 'Eighteen',
          number: '18',
          imagePath: AppImages.eighteen,
          referenceImagePath: AppImages.eighteenPic,
        ),
        CountingModel(
          name: 'Nineteen',
          number: '19',
          imagePath: AppImages.nineteen,
          referenceImagePath: AppImages.nineteenPic,
        ),
        CountingModel(
          name: 'Twenty',
          number: '20',
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
