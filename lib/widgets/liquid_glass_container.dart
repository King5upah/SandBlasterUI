import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';

/// The core Liquid Glass primitive — frosted glass surface with specular highlight,
/// gradient border, and optional mouse-tracking shimmer.
class LiquidGlassContainer extends StatefulWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final double borderRadius;
  final double blur;
  final Color? surfaceColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding; // Changed to nullable
  final bool showSpecular;
  final bool interactive;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin; // Added
  final BoxShadow? shadowOverride;
  final HitTestBehavior hitTestBehavior; // Added

  const LiquidGlassContainer({
    super.key,
    this.child, // Changed from required
    this.width,
    this.height,
    this.borderRadius = LiquidGlassTheme.radiusMd,
    this.blur = LiquidGlassTheme.blurMedium,
    this.surfaceColor,
    this.borderColor,
    this.padding, // Changed from default value
    this.showSpecular = false,
    this.interactive = false,
    this.onTap,
    this.margin, // Added
    this.shadowOverride,
    this.hitTestBehavior = HitTestBehavior.deferToChild, // Added
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
      child: Listener(
        behavior: widget.hitTestBehavior,
        onPointerDown: isInteractive ? (_) => setState(() => _pressed = true) : null,
        onPointerUp: isInteractive ? (_) {
          setState(() => _pressed = false);
          widget.onTap?.call();
        } : null,
        onPointerCancel: isInteractive ? (_) => setState(() => _pressed = false) : null,
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: widget.width,
            height: widget.height,
            padding: widget.padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: [
                widget.shadowOverride ??
                    BoxShadow(
                      color: context.sbTheme.glassShadow,
                      blurRadius: shadowSpread * 1.5,
                      spreadRadius: _hovered ? 2 : 0,
                      offset: const Offset(0, 12),
                    ),
                // Crisp ambient shadow layer
                if (widget.shadowOverride == null)
                  BoxShadow(
                    color: context.sbTheme.glassShadow.withOpacity(context.sbTheme.glassShadow.opacity * 0.5),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
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
                        // 1. Solid surface tint (body structure to prevent mudiness)
                        color: widget.surfaceColor ?? context.sbTheme.glassSurface,
                        borderRadius: BorderRadius.circular(widget.borderRadius),
                      ),
                    ),
                  ),
                  // 2. Center luminous shine (simulates light passing through a frosted lens)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 1.2,
                        colors: [
                          Colors.white.withOpacity(Theme.of(context).brightness == Brightness.light ? 0.3 : 0.08),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // 3. Diagonal glass glint for volumetric depth
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.5),
                          Colors.white.withOpacity(0.0),
                          Theme.of(context).brightness == Brightness.light 
                              ? Colors.black.withOpacity(0.05) 
                              : Colors.white.withOpacity(0.05),
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
                  // High-fidelity Border gradient
                  if (widget.borderColor != null)
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(widget.borderRadius),
                          border: Border.all(
                            color: widget.borderColor!,
                            width: 1.0,
                          ),
                        ),
                      ),
                    )
                  else
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _GlassStrokePainter(
                          radius: widget.borderRadius,
                          brightness: Theme.of(context).brightness,
                        ),
                      ),
                    ),
                  // Content
                  Padding(
                    padding: widget.padding ?? const EdgeInsets.all(16),
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

class _GlassStrokePainter extends CustomPainter {
  final double radius;
  final Brightness brightness;

  _GlassStrokePainter({required this.radius, required this.brightness});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    
    final isDark = brightness == Brightness.dark;

    final paintTL = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(isDark ? 0.6 : 0.9),
          Colors.white.withOpacity(isDark ? 0.1 : 0.3),
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 1.0],
      ).createShader(rect);

    final paintBR = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.transparent,
          isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05),
          isDark ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.15),
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(rect);

    canvas.drawRRect(rrect, paintBR);
    canvas.drawRRect(rrect, paintTL);
  }

  @override
  bool shouldRepaint(covariant _GlassStrokePainter old) => old.radius != radius || old.brightness != brightness;
}
