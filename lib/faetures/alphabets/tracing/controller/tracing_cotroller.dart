import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/utils/mask_comparator.dart';

class TracingController extends GetxController {
  RxList<Offset?> points = <Offset?>[].obs;
  Rx<ui.Image?> maskImage = Rx<ui.Image?>(null);
  RxBool showSuccess = false.obs;
  String currentLetter = 'A';

  void setLetter(String letter) async {
    currentLetter = letter;
    showSuccess.value = false;
    points.clear();
    maskImage.value = await loadMask(letter);
  }

  Future<ui.Image> loadMask(String letter) async {
    final data = await rootBundle.load('assets/tracing_masks/$letter.png');
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  void addPoint(Offset point) => points.add(point);
  void endDrawing() => points.add(null);

  void compareWithMask() async {
    final match = await MaskComparator.evaluateMatch(points, maskImage.value!);
    if (match >= 0.7) {
      showSuccess.value = true;
      await Future.delayed(Duration(seconds: 2));
      showSuccess.value = false;
    }
  }

  void nextLetter() {
    if (currentLetter == 'Z') return;
    setLetter(String.fromCharCode(currentLetter.codeUnitAt(0) + 1));
  }
}
