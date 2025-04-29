import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import '../../../data/models/color_model.dart';

class ColorsController extends GetxController {
  final FlutterTts tts = FlutterTts();

  var colors = <ColorModel>[
    ColorModel(name: 'Red', color: Colors.red),
    ColorModel(name: 'Green', color: Colors.green),
    ColorModel(name: 'Blue', color: Colors.blue),
    ColorModel(name: 'Yellow', color: Colors.yellow),
    ColorModel(name: 'Orange', color: Colors.orange),
    ColorModel(name: 'Purple', color: Colors.purple),
    ColorModel(name: 'Pink', color: Colors.pink),
    ColorModel(name: 'Brown', color: Colors.brown),
    ColorModel(name: 'Black', color: Colors.black),
    ColorModel(name: 'White', color: Colors.white),
    ColorModel(name: 'Grey', color: Colors.grey),
    ColorModel(name: 'Teal', color: Colors.teal),
    ColorModel(name: 'Indigo', color: Colors.indigo),
    ColorModel(name: 'Amber', color: Colors.amber),
    ColorModel(name: 'Cyan', color: Colors.cyan),
    ColorModel(name: 'Lime', color: Colors.lime),
    ColorModel(name: 'Deep Orange', color: Colors.deepOrange),
    ColorModel(name: 'Light Blue', color: Colors.lightBlue),
    ColorModel(name: 'Light Green', color: Colors.lightGreen),
    ColorModel(name: 'Blue Grey', color: Colors.blueGrey),
    ColorModel(name: 'Pink Accent', color: Colors.pinkAccent),
    ColorModel(name: 'Purple Accent', color: Colors.purpleAccent),
    ColorModel(name: 'Deep Purple', color: Colors.deepPurple),
    ColorModel(name: 'Lime Accent', color: Colors.limeAccent),
  ].obs;

  var currentIndex = 0.obs;

  void setIndex(int index) {
    currentIndex.value = index;
    speakColor();
  }

  void next() {
    if (currentIndex < colors.length - 1) {
      currentIndex++;
      speakColor();
    }
  }

  void previous() {
    if (currentIndex > 0) {
      currentIndex--;
      speakColor();
    }
  }

  void speakColor() {
    Future.delayed(Duration(seconds: 1), () {
      tts.speak(colors[currentIndex.value].name);
    });
  }

  void reListen() => speakColor();
}
