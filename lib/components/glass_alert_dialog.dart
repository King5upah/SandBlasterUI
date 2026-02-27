import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';
import '../widgets/liquid_glass_container.dart';

class GlassAlertDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry titlePadding;
  final EdgeInsetsGeometry actionsPadding;
  final MainAxisAlignment actionsAlignment;
  final bool showShadow;

  const GlassAlertDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.titlePadding = const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
    this.actionsPadding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.actionsAlignment = MainAxisAlignment.end,
    this.showShadow = true,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    Widget? title,
    Widget? content,
    List<Widget>? actions,
    bool barrierDismissible = true,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: 'dismiss',
      barrierColor: Colors.black.withValues(alpha: 0.6),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => GlassAlertDialog(
        title: title,
        content: content,
        actions: actions,
      ),
      transitionBuilder: (ctx, anim, _, child) {
        final curve = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 8 * anim.value,
            sigmaY: 8 * anim.value,
          ),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(curve),
            child: FadeTransition(opacity: curve, child: child),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LiquidGlassTheme.radiusLg),
      ),
      child: LiquidGlassContainer(
        showShadow: showShadow,
        borderRadius: LiquidGlassTheme.radiusLg,
        padding: EdgeInsets.zero,
        surfaceColor: context.sbTheme.glassElevated,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null)
              Padding(
                padding: titlePadding,
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.titleLarge!,
                  child: title!,
                ),
              ),
            if (content != null)
              Padding(
                padding: contentPadding,
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyMedium!,
                  child: content!,
                ),
              ),
            if (actions != null && actions!.isNotEmpty)
              Padding(
                padding: actionsPadding,
                child: OverflowBar(
                  alignment: actionsAlignment,
                  spacing: 8,
                  children: actions!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
