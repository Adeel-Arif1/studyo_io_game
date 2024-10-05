import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;
class TrianglePainter extends CustomPainter {
  final String direction;
  final int lineCount;

  TrianglePainter({required this.direction, required this.lineCount});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.fill;

    Path path = Path();
    if (direction == 'down') {
      path.moveTo(0, 0);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, 0);
      path.close();
    } else if (direction == 'up') {
      path.moveTo(size.width, size.height);
      path.lineTo(size.width / 2, 0);
      path.lineTo(0, size.height);
      path.close();
    } else if (direction == 'right') {
      path.moveTo(0, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(0, size.height);
      path.close();
    } else if (direction == 'left') {
      path.moveTo(size.width, 0);
      path.lineTo(0, size.height / 2);
      path.lineTo(size.width, size.height);
      path.close();
    }

    canvas.drawPath(path, paint);

    final textSpan = TextSpan(
      text: lineCount.toString(),
      style: TextStyle(color: Colors.white, fontSize: 12),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: ui.TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(size.width / 2 - textPainter.width / 2,
          size.height / 2 - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
