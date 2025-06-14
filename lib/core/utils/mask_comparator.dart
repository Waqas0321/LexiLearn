import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class MaskComparator {
  static Future<double> evaluateMatch(List<Offset?> points, ui.Image maskImage) async {
    final pixelData = await _getMaskPixels(maskImage);
    int hit = 0;
    int total = 0;

    for (final point in points) {
      if (point != null) {
        final x = point.dx.clamp(0, maskImage.width - 1).toInt();
        final y = point.dy.clamp(0, maskImage.height - 1).toInt();
        final pixelIndex = y * maskImage.width + x;

        if (pixelData[pixelIndex] == 0xFF000000) { // black letter pixel
          hit++;
        }
        total++;
      }
    }

    if (total == 0) return 0.0;
    return hit / total;
  }

  static Future<List<int>> _getMaskPixels(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    final pixels = byteData!.buffer.asUint32List();
    return pixels.toList();
  }
}
