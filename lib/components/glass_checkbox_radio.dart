import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';
import '../widgets/liquid_glass_container.dart';

class GlassCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final Color? activeColor;
  final bool showShadow;

  const GlassCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.activeColor,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = activeColor ?? context.sbTheme.accent;

    return Semantics(
      checked: value,
      label: label ?? 'Checkbox',
      enabled: onChanged != null,
      child: GestureDetector(
        onTap: onChanged != null ? () => onChanged!(!value) : null,
        child: MouseRegion(
          cursor: onChanged != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LiquidGlassContainer(
                showShadow: showShadow,
                width: 24,
                height: 24,
                borderRadius: 6.0,
                padding: EdgeInsets.zero,
                surfaceColor: value ? color.withValues(alpha: 0.2) : Colors.transparent,
                borderColor: value ? color.withValues(alpha: 0.6) : context.sbTheme.glassBorder,
                child: AnimatedOpacity(
                  opacity: value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Center(
                    child: Icon(
                      Icons.check_rounded,
                      size: 16,
                      color: color,
                    ),
                  ),
                ),
              ),
              if (label != null) ...[
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    label!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: context.sbTheme.textPrimary,
                        ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class GlassRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T>? onChanged;
  final String? label;
  final Color? activeColor;
  final bool showShadow;

  const GlassRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.label,
    this.activeColor,
    this.showShadow = true,
  });

  bool get _selected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    final color = activeColor ?? context.sbTheme.accent;

    return Semantics(
      checked: _selected,
      label: label ?? 'Radio',
      enabled: onChanged != null,
      child: GestureDetector(
        onTap: onChanged != null ? () => onChanged!(value) : null,
        child: MouseRegion(
          cursor: onChanged != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LiquidGlassContainer(
                showShadow: showShadow,
                width: 24,
                height: 24,
                borderRadius: 12.0, // Fully round
                padding: EdgeInsets.zero,
                surfaceColor: _selected ? color.withValues(alpha: 0.15) : Colors.transparent,
                borderColor: _selected ? color.withValues(alpha: 0.6) : context.sbTheme.glassBorder,
                child: AnimatedScale(
                  scale: _selected ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutBack,
                  child: Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                      ),
                    ),
                  ),
                ),
              ),
              if (label != null) ...[
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    label!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: context.sbTheme.textPrimary,
                        ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
