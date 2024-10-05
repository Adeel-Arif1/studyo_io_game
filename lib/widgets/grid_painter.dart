import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final int verticalLines;
  final int horizontalLines;
  final List<List<bool>> selectedTileStates;

  GridPainter(
      this.verticalLines, this.horizontalLines, this.selectedTileStates);

  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    for (int i = 0; i <= verticalLines; i++) {
      double dy = i * size.height / (verticalLines + 1);
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), linePaint);
    }

    for (int i = 0; i <= horizontalLines; i++) {
      double dx = i * size.width / (horizontalLines + 1);
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), linePaint);
    }

    Paint fillPaint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.fill;

    for (int row = 0; row < verticalLines; row++) {
      for (int col = 0; col < horizontalLines; col++) {
        if (selectedTileStates[row][col]) {
          double left = col * size.width / (horizontalLines + 1);
          double top = row * size.height / (verticalLines + 1);
          double right = (col + 1) * size.width / (horizontalLines + 1);
          double bottom = (row + 1) * size.height / (verticalLines + 1);

          Rect tileRect = Rect.fromLTRB(left, top, right, bottom);
          canvas.drawRect(tileRect, fillPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
