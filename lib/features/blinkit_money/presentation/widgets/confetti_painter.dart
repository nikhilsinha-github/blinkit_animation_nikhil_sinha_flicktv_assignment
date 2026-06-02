import 'package:flutter/material.dart';

class ConfettiParticle {
  final Color color;
  final double size;
  final double speedX; 
  final double speedY; 
  final double rotationSpeed;

  ConfettiParticle({
    required this.color,
    required this.size,
    required this.speedX,
    required this.speedY,
    required this.rotationSpeed,
  });
}

class ConfettiPainter extends CustomPainter {
  final double progress; 
  final List<ConfettiParticle> particles;

  final double gravity = 4000.0;

  ConfettiPainter({required this.progress, required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) return;

    final paint = Paint()..style = PaintingStyle.fill;

    canvas.translate(size.width / 2, size.height / 2.2);

    for (var particle in particles) {
      double t = progress;

      double currentX = particle.speedX * t;
      double currentY = (particle.speedY * t) + (0.5 * gravity * t * t);
      double currentRotation = particle.rotationSpeed * t * 15;

      canvas.save();
      canvas.translate(currentX, currentY);
      canvas.rotate(currentRotation);

      double opacity = 1.0;
      if (t > 0.7) {
        opacity = (1.0 - t) / 0.3; 
      }

      paint.color = particle.color.withOpacity(opacity.clamp(0.0, 1.0));

      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: particle.size,
          height: particle.size * 2.2, 
        ),
        paint,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant ConfettiPainter oldDelegate) => true;
}
