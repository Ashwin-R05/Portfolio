/// Interactive particle canvas background using CustomPainter.
///
/// Renders a constellation of floating particles connected by faint lines,
/// creating a living tech-aesthetic backdrop. Particles respond to cursor
/// proximity (web) and animate continuously.
///
/// Performance considerations:
/// - Particle count scales with screen size (fewer on mobile)
/// - Uses RepaintBoundary to avoid repainting the rest of the tree
/// - Lines are only drawn between particles within a threshold distance
import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// A single particle in the constellation.
class _Particle {
  double x;
  double y;
  double vx;
  double vy;
  double radius;
  double opacity;

  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.opacity,
  });
}

/// Full-screen animated particle background.
///
/// Place this behind your content using a Stack. The canvas automatically
/// sizes to fill its parent.
class ParticleCanvas extends StatefulWidget {
  /// Number of particles. Defaults to 80, but the widget will
  /// automatically reduce this on smaller screens.
  final int particleCount;

  /// Whether to react to mouse/touch position.
  final bool interactive;

  const ParticleCanvas({
    super.key,
    this.particleCount = 80,
    this.interactive = true,
  });

  @override
  State<ParticleCanvas> createState() => _ParticleCanvasState();
}

class _ParticleCanvasState extends State<ParticleCanvas>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final Random _random = Random();
  Offset? _mousePosition;
  Size _canvasSize = Size.zero;

  @override
  void initState() {
    super.initState();
    // Run at 60fps — the controller drives continuous repaints.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  /// Initialize particles when the canvas size is known.
  void _initParticles(Size size) {
    if (size == _canvasSize && _particles.isNotEmpty) return;
    _canvasSize = size;
    _particles.clear();

    // Scale particle count based on screen area (fewer on mobile).
    final area = size.width * size.height;
    final count = (widget.particleCount * (area / (1920 * 1080)))
        .clamp(20, widget.particleCount)
        .toInt();

    for (int i = 0; i < count; i++) {
      _particles.add(_Particle(
        x: _random.nextDouble() * size.width,
        y: _random.nextDouble() * size.height,
        vx: (_random.nextDouble() - 0.5) * 0.5,
        vy: (_random.nextDouble() - 0.5) * 0.5,
        radius: _random.nextDouble() * 2 + 1,
        opacity: _random.nextDouble() * 0.5 + 0.2,
      ));
    }
  }

  /// Update particle positions each frame.
  void _updateParticles() {
    for (final p in _particles) {
      p.x += p.vx;
      p.y += p.vy;

      // Wrap around edges for seamless movement.
      if (p.x < 0) p.x = _canvasSize.width;
      if (p.x > _canvasSize.width) p.x = 0;
      if (p.y < 0) p.y = _canvasSize.height;
      if (p.y > _canvasSize.height) p.y = 0;

      // Cursor proximity effect: particles near the mouse glow brighter
      // and are gently pushed away.
      if (_mousePosition != null && widget.interactive) {
        final dx = p.x - _mousePosition!.dx;
        final dy = p.y - _mousePosition!.dy;
        final dist = sqrt(dx * dx + dy * dy);
        if (dist < 150) {
          // Gentle repulsion
          final force = (150 - dist) / 150 * 0.3;
          p.vx += dx / dist * force;
          p.vy += dy / dist * force;
          // Brighten
          p.opacity = (p.opacity + 0.02).clamp(0.0, 0.9);
        } else {
          // Slowly return to base opacity
          p.opacity = (p.opacity - 0.005).clamp(0.2, 0.9);
        }

        // Dampen velocity to prevent particles from flying off.
        p.vx *= 0.99;
        p.vy *= 0.99;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: MouseRegion(
        onHover: widget.interactive
            ? (event) => _mousePosition = event.localPosition
            : null,
        onExit: widget.interactive ? (_) => _mousePosition = null : null,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = Size(constraints.maxWidth, constraints.maxHeight);
            _initParticles(size);

            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                _updateParticles();
                return CustomPaint(
                  size: size,
                  painter: _ParticlePainter(
                    particles: _particles,
                    mousePosition: _mousePosition,
                    isDark: Theme.of(context).brightness == Brightness.dark,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

/// CustomPainter that renders particles and their connecting lines.
class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final Offset? mousePosition;
  final bool isDark;

  /// Max distance between particles for a connecting line.
  static const double _connectionDistance = 120;

  _ParticlePainter({
    required this.particles,
    this.mousePosition,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final particlePaint = Paint()..style = PaintingStyle.fill;
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final baseColor =
        isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final lineColor =
        isDark ? AppColors.particleLine : AppColors.lightPrimary.withValues(alpha: 0.12);

    // Draw connecting lines between nearby particles.
    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final dx = particles[i].x - particles[j].x;
        final dy = particles[i].y - particles[j].y;
        final dist = sqrt(dx * dx + dy * dy);

        if (dist < _connectionDistance) {
          final opacity = (1 - dist / _connectionDistance) * 0.4;
          linePaint.color = lineColor.withValues(alpha: opacity);
          canvas.drawLine(
            Offset(particles[i].x, particles[i].y),
            Offset(particles[j].x, particles[j].y),
            linePaint,
          );
        }
      }
    }

    // Draw cursor glow radius.
    if (mousePosition != null) {
      final glowPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            AppColors.cyanGlow,
            Colors.transparent,
          ],
        ).createShader(
          Rect.fromCircle(center: mousePosition!, radius: 150),
        );
      canvas.drawCircle(mousePosition!, 150, glowPaint);
    }

    // Draw particles.
    for (final p in particles) {
      particlePaint.color = baseColor.withValues(alpha: p.opacity);
      canvas.drawCircle(Offset(p.x, p.y), p.radius, particlePaint);

      // Subtle outer glow on brighter particles.
      if (p.opacity > 0.5) {
        particlePaint.color = baseColor.withValues(alpha: p.opacity * 0.2);
        canvas.drawCircle(Offset(p.x, p.y), p.radius * 3, particlePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}
