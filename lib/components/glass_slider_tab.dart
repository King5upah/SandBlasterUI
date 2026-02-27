import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';
import '../widgets/liquid_glass_container.dart';

class GlassSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final Color? activeColor;

  const GlassSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.activeColor,
  });

  @override
  State<GlassSlider> createState() => _GlassSliderState();
}

class _GlassSliderState extends State<GlassSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.activeColor ?? context.sbTheme.accent;
    final t = (widget.value - widget.min) / (widget.max - widget.min);

    return Semantics(
      slider: true,
      value: widget.value.toStringAsFixed(2),
      onIncrease: () {
        final next = (widget.value + 0.1).clamp(widget.min, widget.max);
        if (next != widget.value) widget.onChanged(next);
      },
      onDecrease: () {
        final next = (widget.value - 0.1).clamp(widget.min, widget.max);
        if (next != widget.value) widget.onChanged(next);
      },
      child: SliderTheme(
        data: SliderThemeData(
          trackHeight: 6,
          activeTrackColor: color,
          inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
          thumbColor: Colors.transparent,
          overlayColor: color.withValues(alpha: 0.1),
          thumbShape: _GlassThumbShape(color: color),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
          trackShape: _GlassTrackShape(color: color, progress: t),
        ),
        child: Slider(
          value: widget.value,
          min: widget.min,
          max: widget.max,
        onChangeStart: (_) {
          _pulseController.repeat(reverse: true);
        },
          onChangeEnd: (_) {
            _pulseController.stop();
            _pulseController.reset();
          },
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}

class _GlassThumbShape extends SliderComponentShape {
  final Color color;
  const _GlassThumbShape({required this.color});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(24, 24);

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final canvas = context.canvas;

    // Glow
    canvas.drawCircle(
      center,
      16,
      Paint()
        ..color = color.withValues(alpha: 0.2)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    // Outer ring
    canvas.drawCircle(
      center,
      12,
      Paint()
        ..color = color.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Inner fill
    canvas.drawCircle(
      center,
      10,
      Paint()
        ..shader = RadialGradient(
          colors: [color, color.withValues(alpha: 0.6)],
        ).createShader(Rect.fromCircle(center: center, radius: 10)),
    );

    // Specular
    canvas.drawCircle(
      center + const Offset(-3, -3),
      3,
      Paint()..color = Colors.white.withValues(alpha: 0.5),
    );
  }
}

class _GlassTrackShape extends RoundedRectSliderTrackShape {
  final Color color;
  final double progress;
  const _GlassTrackShape({required this.color, required this.progress});

  @override
  void paint(PaintingContext context, Offset offset,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required Offset thumbCenter,
      Offset? secondaryOffset,
      bool isDiscrete = false,
      bool isEnabled = false,
      double additionalActiveTrackHeight = 0}) {
    final canvas = context.canvas;
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
    );

    final rrect = RRect.fromRectAndRadius(trackRect, const Radius.circular(3));

    // Inactive track
    canvas.drawRRect(
      rrect,
      Paint()..color = Colors.white.withValues(alpha: 0.1),
    );

    // Active track with gradient
    final activeRect = RRect.fromLTRBR(
      trackRect.left,
      trackRect.top,
      thumbCenter.dx,
      trackRect.bottom,
      const Radius.circular(3),
    );
    canvas.drawRRect(
      activeRect,
      Paint()
        ..shader = LinearGradient(
          colors: [color.withValues(alpha: 0.6), color],
        ).createShader(trackRect),
    );

    // Glow on active
    canvas.drawRRect(
      activeRect,
      Paint()
        ..color = color.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
  }
}

class GlassTabBar extends StatefulWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final Color? activeColor;
  final bool showShadow;

  const GlassTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
    this.activeColor,
    this.showShadow = true,
  });

  @override
  State<GlassTabBar> createState() => _GlassTabBarState();
}

class _GlassTabBarState extends State<GlassTabBar> {
  @override
  Widget build(BuildContext context) {
    final color = widget.activeColor ?? context.sbTheme.accent;

    return LiquidGlassContainer(
      showShadow: widget.showShadow,
      borderRadius: LiquidGlassTheme.radiusPill,
      padding: const EdgeInsets.all(4),
      surfaceColor: Colors.white.withValues(alpha: 0.05),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.tabs.asMap().entries.map((e) {
          final isSelected = e.key == widget.selectedIndex;
          return Semantics(
            button: true,
            selected: isSelected,
            label: e.value,
            child: GestureDetector(
              onTap: () => widget.onChanged(e.key),
              child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOutCubic,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(LiquidGlassTheme.radiusPill),
                  color: isSelected ? color.withValues(alpha: 0.2) : Colors.transparent,
                  border: isSelected
                      ? Border.all(color: color.withValues(alpha: 0.4), width: 1)
                      : Border.all(color: Colors.transparent, width: 1),
                ),
                child: Text(
                  e.value,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: isSelected ? color : context.sbTheme.textSecondary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
