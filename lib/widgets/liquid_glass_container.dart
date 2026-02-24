import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';

/// The core Liquid Glass primitive — frosted glass surface with specular highlight,
/// gradient border, and optional mouse-tracking shimmer.
class LiquidGlassContainer extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final double blur;
  final Color? surfaceColor;
  final Color? borderColor;
  final EdgeInsetsGeometry padding;
  final bool showSpecular;
  final bool interactive;
  final VoidCallback? onTap;
  final BoxShadow? shadowOverride;

  const LiquidGlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = LiquidGlassTheme.radiusMd,
    this.blur = LiquidGlassTheme.blurMedium,
    this.surfaceColor,
    this.borderColor,
    this.padding = const EdgeInsets.all(16),
    this.showSpecular = true,
    this.interactive = false,
    this.onTap,
    this.shadowOverride,
  });

  @override
  State<LiquidGlassContainer> createState() => _LiquidGlassContainerState();
}

class _LiquidGlassContainerState extends State<LiquidGlassContainer>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  bool _pressed = false;
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnim;
  Offset _mousePos = Offset.zero;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _shimmerAnim = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
    if (widget.interactive) {
      _shimmerController.repeat();
    }
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isInteractive = widget.interactive || widget.onTap != null;
    final scale = _pressed ? 0.97 : (_hovered ? 1.02 : 1.0);
    final shadowSpread = _hovered ? 20.0 : 8.0;
    final shadowOpacity = _hovered ? 0.35 : 0.15;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      onHover: (e) => setState(() => _mousePos = e.localPosition),
      cursor: isInteractive ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) {
          setState(() => _pressed = false);
          widget.onTap?.call();
        },
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: [
                widget.shadowOverride ??
                    BoxShadow(
                      color: LiquidGlassTheme.accentGlow.withOpacity(shadowOpacity),
                      blurRadius: shadowSpread,
                      spreadRadius: _hovered ? 4 : 0,
                    ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: Stack(
                children: [
                  // Backdrop blur
                  BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: widget.blur,
                      sigmaY: widget.blur,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.surfaceColor ?? LiquidGlassTheme.glassSurface,
                        borderRadius: BorderRadius.circular(widget.borderRadius),
                      ),
                    ),
                  ),
                  // Inner gradient fill
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.12),
                          Colors.white.withOpacity(0.03),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                  // Specular highlight (top-left arc)
                  if (widget.showSpecular)
                    Positioned(
                      top: -20,
                      left: -20,
                      child: Container(
                        width: 180,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          gradient: RadialGradient(
                            colors: [
                              Colors.white.withOpacity(0.25),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  // Mouse-tracking shimmer
                  if (_hovered && widget.interactive)
                    Positioned.fill(
                      child: AnimatedBuilder(
                        animation: _shimmerAnim,
                        builder: (_, __) => CustomPaint(
                          painter: _ShimmerPainter(
                            progress: _shimmerAnim.value,
                            mousePos: _mousePos,
                          ),
                        ),
                      ),
                    ),
                  // Border gradient
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(widget.borderRadius),
                        border: Border.all(
                          color: widget.borderColor ?? LiquidGlassTheme.glassBorder,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: widget.padding,
                    child: widget.child,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShimmerPainter extends CustomPainter {
  final double progress;
  final Offset mousePos;
  const _ShimmerPainter({required this.progress, required this.mousePos});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment(progress - 1, 0),
        end: Alignment(progress, 0),
        colors: [
          Colors.transparent,
          Colors.white.withOpacity(0.06),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(_ShimmerPainter old) => old.progress != progress;
}
