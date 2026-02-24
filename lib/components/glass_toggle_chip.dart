import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';
import '../widgets/liquid_glass_container.dart';

class GlassToggle extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;

  const GlassToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
  });

  @override
  State<GlassToggle> createState() => _GlassToggleState();
}

class _GlassToggleState extends State<GlassToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _thumbAnim;
  late Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: widget.value ? 1.0 : 0.0,
    );
    _thumbAnim = CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic);
    _glowAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void didUpdateWidget(GlassToggle old) {
    super.didUpdateWidget(old);
    if (old.value != widget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
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
    final activeColor = widget.activeColor ?? context.sbTheme.accent;

    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (ctx, _) {
            return Container(
              width: 56,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LiquidGlassTheme.radiusPill),
                color: Color.lerp(
                  Colors.white.withOpacity(0.1),
                  activeColor.withOpacity(0.3),
                  _thumbAnim.value,
                ),
                border: Border.all(
                  color: Color.lerp(
                    context.sbTheme.glassBorder,
                    activeColor.withOpacity(0.7),
                    _thumbAnim.value,
                  )!,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: activeColor.withOpacity(0.3 * _glowAnim.value),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    left: widget.value ? 28 : 3,
                    top: 3,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.lerp(
                          Colors.white.withOpacity(0.8),
                          activeColor,
                          _thumbAnim.value,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.4 * _thumbAnim.value),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class GlassChip extends StatelessWidget {
  final String label;
  final Color? color;
  final IconData? icon;
  final bool outlined;

  const GlassChip({
    super.key,
    required this.label,
    this.color,
    this.icon,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? context.sbTheme.accent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LiquidGlassTheme.radiusPill),
        color: outlined ? Colors.transparent : c.withOpacity(0.15),
        border: Border.all(color: c.withOpacity(outlined ? 0.7 : 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: c, size: 14),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: c),
          ),
        ],
      ),
    );
  }
}
