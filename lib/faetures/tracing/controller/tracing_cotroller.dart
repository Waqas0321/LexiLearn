import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TracingController extends GetxController {

  void onTracingCompleted() async {
    await Get.defaultDialog(
      title: "Success!",
      middleText: "You completed the tracing!",
      confirm: TextButton(
        onPressed: () {
          Get.back();
          Get.back();
        },
        child: const Text("OK"),
      ),
    );
  }
}
