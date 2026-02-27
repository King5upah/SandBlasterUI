import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';
import '../widgets/liquid_glass_container.dart';

enum GlassButtonVariant { primary, ghost, icon }

class GlassButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final GlassButtonVariant variant;
  final Color? accentColor;
  final bool loading;
  final HitTestBehavior hitTestBehavior;
  final bool showShadow;

  const GlassButton({
    super.key,
    this.label,
    this.icon,
    this.onPressed,
    this.variant = GlassButtonVariant.primary,
    this.accentColor,
    this.loading = false,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? context.sbTheme.accent;

    if (variant == GlassButtonVariant.icon) {
      return LiquidGlassContainer(
          semanticLabel: label ?? 'Icon Button',
          showShadow: showShadow,
          borderRadius: LiquidGlassTheme.radiusPill,
          padding: const EdgeInsets.all(12),
          interactive: true,
          onTap: onPressed,
          hitTestBehavior: hitTestBehavior,
          surfaceColor: color.withValues(alpha: 0.15),
          borderColor: color.withValues(alpha: 0.4),
          child: Icon(icon, color: color, size: 22),
        );
    }

    return LiquidGlassContainer(
        semanticLabel: label ?? 'Button',
        showShadow: showShadow,
        borderRadius: LiquidGlassTheme.radiusPill,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        interactive: true,
        onTap: onPressed,
        hitTestBehavior: hitTestBehavior,
        surfaceColor: variant == GlassButtonVariant.primary
            ? color.withValues(alpha: 0.2)
            : Colors.transparent,
        borderColor: color.withValues(alpha: 0.5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (loading)
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: color,
                ),
              )
            else if (icon != null) ...[
              Icon(icon, color: color, size: 18),
              if (label != null) const SizedBox(width: 8),
            ],
            if (label != null)
              Text(
                label!,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color),
              ),
          ],
        ),
      );
  }
}
