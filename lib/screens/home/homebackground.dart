/*import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyPainterPurple extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.deepPurpleAccent.withOpacity(0.5);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi/2,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class MyPainterGreen extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.greenAccent.withOpacity(0.5);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi/2,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class MyPainterPurple2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.deepPurpleAccent.withOpacity(0.5);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height/2, size.width),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class MyPainterGreen2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.greenAccent.withOpacity(0.5);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height/2, size.width),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}*/