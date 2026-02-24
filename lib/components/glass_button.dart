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

  const GlassButton({
    super.key,
    this.label,
    this.icon,
    this.onPressed,
    this.variant = GlassButtonVariant.primary,
    this.accentColor,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? context.sbTheme.accent;

    if (variant == GlassButtonVariant.icon) {
      return LiquidGlassContainer(
        borderRadius: LiquidGlassTheme.radiusPill,
        padding: const EdgeInsets.all(12),
        interactive: true,
        onTap: onPressed,
        surfaceColor: color.withOpacity(0.15),
        borderColor: color.withOpacity(0.4),
        child: Icon(icon, color: color, size: 22),
      );
    }

    return LiquidGlassContainer(
      borderRadius: LiquidGlassTheme.radiusPill,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      interactive: true,
      onTap: onPressed,
      surfaceColor: variant == GlassButtonVariant.primary
          ? color.withOpacity(0.2)
          : Colors.transparent,
      borderColor: color.withOpacity(0.5),
      shadowOverride: BoxShadow(
        color: color.withOpacity(0.25),
        blurRadius: 20,
        spreadRadius: 0,
      ),
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
