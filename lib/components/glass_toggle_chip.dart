import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';
import '../widgets/liquid_glass_container.dart';

class GlassToggle extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? thumbColor;
  final Widget? activeThumbIcon;
  final Widget? inactiveThumbIcon;
  final bool showShadow;

  const GlassToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
    this.activeThumbIcon,
    this.inactiveThumbIcon,
    this.showShadow = true,
  });

  @override
  State<GlassToggle> createState() => _GlassToggleState();
}

class _GlassToggleState extends State<GlassToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _thumbAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: widget.value ? 1.0 : 0.0,
    );
    _thumbAnim = CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic);
  }

  @override
  void didUpdateWidget(GlassToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
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
    final actTrackColor = widget.activeTrackColor ?? context.sbTheme.accent;
    final inactTrackColor = widget.inactiveTrackColor ?? Colors.white.withValues(alpha: 0.1);
    final currentThumbColor = widget.thumbColor ?? Color.lerp(Colors.white.withValues(alpha: 0.8), actTrackColor, _thumbAnim.value)!;

    return Semantics(
      toggled: widget.value,
      label: 'Toggle',
      child: GestureDetector(
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
                  inactTrackColor,
                  actTrackColor.withValues(alpha: 0.3),
                  _thumbAnim.value,
                ),
                border: Border.all(
                  color: Color.lerp(
                    context.sbTheme.glassBorder,
                    actTrackColor.withValues(alpha: 0.7),
                    _thumbAnim.value,
                  )!,
                  width: 1.5,
                ),
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
                        color: currentThumbColor,
                        boxShadow: widget.showShadow ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ] : null,
                      ),
                      child: Center(
                        child: widget.value && widget.activeThumbIcon != null
                            ? widget.activeThumbIcon
                            : !widget.value && widget.inactiveThumbIcon != null
                                ? widget.inactiveThumbIcon
                                : Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withValues(alpha: 0.4 * _thumbAnim.value),
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
      ),
    );
  }
}

class GlassChip extends StatelessWidget {
  final String label;
  final Color? color;
  final IconData? icon;
  final bool outlined;
  final VoidCallback? onTap;
  final HitTestBehavior hitTestBehavior;
  final bool showShadow;

  const GlassChip({
    super.key,
    required this.label,
    this.color,
    this.icon,
    this.outlined = false,
    this.onTap,
    this.hitTestBehavior = HitTestBehavior.deferToChild,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? context.sbTheme.accent;
    return Semantics(
      label: label,
      button: onTap != null,
      child: LiquidGlassContainer(
        showShadow: showShadow,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        borderRadius: LiquidGlassTheme.radiusPill,
        surfaceColor: outlined ? Colors.transparent : c.withValues(alpha: 0.15),
        borderColor: c.withValues(alpha: outlined ? 0.7 : 0.3),
        interactive: onTap != null,
        onTap: onTap,
        hitTestBehavior: hitTestBehavior,
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
      ),
    );
  }
}
