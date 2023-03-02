import 'dart:math';

import 'package:flutter/material.dart';

class LineupPlaceholderPainter extends CustomPainter {
  bool isRotate;

  @override
  void paint(Canvas canvas, Size size) {
    // width 80
    var width = size.width;
    var height = size.height;
    var paint = Paint()
      ..color = Colors.white54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    var center = Offset(width / 2, height / 2);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(isRotate ? pi : 0);
    canvas.translate(-center.dx, -center.dy);

    var path = Path();
    path.moveTo(width * 0.25, 0);
    path.lineTo(width * 0.25, width * 0.2);
    path.lineTo(width * 0.75, width * 0.2);
    path.lineTo(width * 0.75, 0);
    path.moveTo(width*0.3875,0);
    path.lineTo(width * 0.3875, width * 0.07);
    path.lineTo(width * 0.6125, width * 0.07);
    path.lineTo(width * 0.6125, 0);
    path.moveTo(width*0.01,0);

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height),
        height: size.width /4,
        width: size.width / 4,
      ),
      180 * pi / 180,
      180 * pi / 180,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.width / 8),
        height: size.width /4,
        width: size.width / 4,
      ),
      38 * pi / 180,
      105 * pi / 180,
      false,
      paint,
    );
    canvas.drawLine(Offset(0, height), Offset(width, height), paint);
    canvas.drawArc(
      Rect.fromCenter(
        center: const Offset(0, 0),
        height: size.width /20,
        width: size.width / 20,
      ),
      0 * pi / 180,
      90 * pi / 180,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(width, 0),
        height: size.width /20,
        width: size.width / 20,
      ),
      90 * pi / 180,
      90 * pi / 180,
      false,
      paint,
    );
    // path.quadraticBezierTo(width * 0.5, 100,width * 0.625, 50);
    canvas.drawPath(path, paint);
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  LineupPlaceholderPainter(this.isRotate);
}