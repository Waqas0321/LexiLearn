import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/well_done_animation.dart';
import '../../../../data/models/alphabet_model.dart';
import '../controller/tracing_cotroller.dart';

class TracingScreen extends StatelessWidget {
  final AlphabetModel alphabet;
  TracingScreen({super.key, required this.alphabet});

  final controller = Get.put(TracingController());

  @override
  Widget build(BuildContext context) {
    controller.setLetter(alphabet.name); // e.g., "A"

    return Scaffold(
      appBar: AppBar(title: Text("Trace ${alphabet.name}")),
      body: Stack(
        children: [
          Obx(() => Positioned.fill(
            child: controller.maskImage.value != null
                ? CustomPaint(
              painter: TracingPainter(
                points: controller.points,
                maskImage: controller.maskImage.value!,
              ),
            )
                : Center(child: CircularProgressIndicator()),
          )),
          GestureDetector(
            onPanUpdate: (details) => controller.addPoint(details.localPosition),
            onPanEnd: (_) => controller.endDrawing(),
          ),
          Positioned(
            bottom: 40,
            left: 40,
            child: ElevatedButton(
              onPressed: controller.compareWithMask,
              child: Text("Check Tracing"),
            ),
          ),
          Positioned(
            bottom: 40,
            right: 40,
            child: ElevatedButton(
              onPressed: controller.nextLetter,
              child: Text("Next Letter"),
            ),
          ),
          Obx(() => controller.showSuccess.value
              ? Center(child: WellDoneAnimation())
              : SizedBox.shrink()),
        ],
      ),
    );
  }
}

class TracingPainter extends CustomPainter {
  final List<Offset?> points;
  final ui.Image maskImage;

  TracingPainter({required this.points, required this.maskImage});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw faded mask image as background
    final paint = Paint()..color = Colors.grey.withOpacity(0.3);
    canvas.drawImageRect(
      maskImage,
      Rect.fromLTWH(0, 0, maskImage.width.toDouble(), maskImage.height.toDouble()),
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );

    // Draw user trace
    final tracePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, tracePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
