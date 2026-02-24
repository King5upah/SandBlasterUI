import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _xAnims;
  late List<Animation<double>> _yAnims;
  final _rand = math.Random(42);

  late List<_OrbConfig> _orbs;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_orbs.length, (i) {
      return AnimationController(
        vsync: this,
        duration: Duration(seconds: 12 + i * 4),
      )..repeat(reverse: true);
    });

    _xAnims = List.generate(_orbs.length, (i) {
      final from = _rand.nextDouble();
      final to = _rand.nextDouble();
      return Tween<double>(begin: from, end: to).animate(
        CurvedAnimation(parent: _controllers[i], curve: Curves.easeInOut),
      );
    });

    _yAnims = List.generate(_orbs.length, (i) {
      final from = _rand.nextDouble();
      final to = _rand.nextDouble();
      return Tween<double>(begin: from, end: to).animate(
        CurvedAnimation(parent: _controllers[i], curve: Curves.easeInOut),
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _orbs = [
      _OrbConfig(color: context.sbTheme.orbViolet, size: 480, opacity: 0.35),
      _OrbConfig(color: context.sbTheme.orbBlue, size: 380, opacity: 0.30),
      _OrbConfig(color: context.sbTheme.orbCyan, size: 320, opacity: 0.25),
      _OrbConfig(color: context.sbTheme.orbPink, size: 280, opacity: 0.20),
      _OrbConfig(color: context.sbTheme.orbEmerald, size: 240, opacity: 0.18),
    ];
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base gradient
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.3, -0.5),
                radius: 1.5,
                colors: [
                  const Color(0xFF0F1B4D),
                  context.sbTheme.bgDeep,
                ],
              ),
            ),
          ),
        ),
        // Orbs — use FractionallySizedBox + Transform to avoid Positioned-inside-LayoutBuilder
        ...List.generate(_orbs.length, (i) {
          return AnimatedBuilder(
            animation: _controllers[i],
            builder: (ctx, _) {
              return Positioned.fill(
                child: CustomPaint(
                  painter: _OrbPainter(
                    config: _orbs[i],
                    xFraction: _xAnims[i].value,
                    yFraction: _yAnims[i].value,
                  ),
                ),
              );
            },
          );
        }),
        // Grain overlay
        Positioned.fill(
          child: CustomPaint(painter: _GrainPainter()),
        ),
        // Content
        Positioned.fill(child: widget.child),
      ],
    );
  }
}

class _OrbPainter extends CustomPainter {
  final _OrbConfig config;
  final double xFraction;
  final double yFraction;

  const _OrbPainter({
    required this.config,
    required this.xFraction,
    required this.yFraction,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = xFraction * size.width;
    final cy = yFraction * size.height;
    final radius = config.size / 2;

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          config.color.withAlpha((config.opacity * 255).round()),
          config.color.withAlpha(0),
        ],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: radius));

    canvas.drawCircle(Offset(cx, cy), radius, paint);
  }

  @override
  bool shouldRepaint(_OrbPainter old) =>
      old.xFraction != xFraction || old.yFraction != yFraction;
}

class _OrbConfig {
  final Color color;
  final double size;
  final double opacity;
  const _OrbConfig({required this.color, required this.size, required this.opacity});
}

class _GrainPainter extends CustomPainter {
  final _rand = math.Random(7);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withAlpha(4);
    for (int i = 0; i < 2000; i++) {
      final x = _rand.nextDouble() * size.width;
      final y = _rand.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), 0.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
