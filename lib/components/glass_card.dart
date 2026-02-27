import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';
import '../widgets/liquid_glass_container.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? subtitle;
  final IconData? leadingIcon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final AlignmentGeometry? contentAlignment;
  final double? contentMaxWidth;
  final double? contentMaxHeight;
  final Color? accentColor;
  final bool showShadow;

  const GlassCard({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.leadingIcon,
    this.trailing,
    this.onTap,
    this.width,
    this.height,
    this.contentAlignment,
    this.contentMaxWidth,
    this.contentMaxHeight,
    this.accentColor,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? context.sbTheme.accent;

    return LiquidGlassContainer(
      showShadow: showShadow,
      width: width,
      height: height,
      borderRadius: LiquidGlassTheme.radiusLg,
      interactive: onTap != null,
      onTap: onTap,
      padding: const EdgeInsets.all(20),
      child: Align(
        alignment: contentAlignment ?? Alignment.topLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: contentMaxWidth ?? double.infinity,
            maxHeight: contentMaxHeight ?? double.infinity,
          ),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null || leadingIcon != null)
            Row(
              children: [
                if (leadingIcon != null) ...[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.withValues(alpha: 0.15),
                      border: Border.all(
                        color: color.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(leadingIcon, color: color, size: 20),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null)
                        Text(
                          title!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: context.sbTheme.textTertiary,
                              ),
                        ),
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          if (title != null || leadingIcon != null) const SizedBox(height: 16),
          child,
        ],
      ),
    ),
   ),
  );
 }
}
