import 'package:flutter/material.dart';

class ChessLogo extends CustomPainter {
  final Color color;
  ChessLogo({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final w = size.width;
    final h = size.height;

    // 1. Move to the bottom-left of the base
    path.moveTo(w * 0.20, h * 0.95);

    // 2. Draw the heavy base
    path.lineTo(w * 0.80, h * 0.95);
    path.lineTo(w * 0.75, h * 0.85);
    path.lineTo(w * 0.25, h * 0.85);
    path.close();

    // 3. Start the body from the base
    path.moveTo(w * 0.30, h * 0.85);

    // 4. The "Chest" curve (protruding forward)
    path.cubicTo(
      w * 0.85,
      h * 0.80, // Control 1
      w * 0.90,
      h * 0.55, // Control 2
      w * 0.65,
      h * 0.40, // End (Neck area)

    );
    // 5. The Head & Ear
    path.lineTo(w * 0.60, h * 0.15); // Top of the ear
    path.lineTo(w * 0.50, h * 0.25); // Back of the head

    // 6. The Snout (Nose)
    path.cubicTo(
      w * 0.25,
      h * 0.25, // Top of snout
      w * 0.15,
      h * 0.45, // Tip of nose
      w * 0.35,
      h * 0.55, // Bottom of jaw
    );

    // 7. Curve back to the neck/back
    path.quadraticBezierTo(
      w * 0.25,
      h * 0.70, // Curve control
      w * 0.30,
      h * 0.85, // Back to start
    );

    canvas.drawPath(path, paint);

    // 8. Optional: Add a small eye cutout
    final eyePaint = Paint()..color = Colors.black.withOpacity(0.5);
    canvas.drawCircle(Offset(w * 0.45, h * 0.40), w * 0.04, eyePaint);
  }

  @override
  bool shouldRepaint(covariant ChessLogo oldDelegate) {
    return color != oldDelegate.color;
  }
}
