import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';
import '../widgets/liquid_glass_container.dart';
import '../components/glass_button.dart';

class GlassModal extends StatelessWidget {
  final String title;
  final Widget body;
  final List<({String label, Color? color, VoidCallback onTap})>? actions;

  const GlassModal({
    super.key,
    required this.title,
    required this.body,
    this.actions,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required Widget body,
    List<({String label, Color? color, VoidCallback onTap})>? actions,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'dismiss',
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => GlassModal(
        title: title,
        body: body,
        actions: actions,
      ),
      transitionBuilder: (ctx, anim, _, child) {
        final curve = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 12 * anim.value,
            sigmaY: 12 * anim.value,
          ),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.1),
              end: Offset.zero,
            ).animate(curve),
            child: FadeTransition(opacity: curve, child: child),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: LiquidGlassContainer(
              borderRadius: LiquidGlassTheme.radiusXl,
              blur: LiquidGlassTheme.blurHeavy,
              surfaceColor: LiquidGlassTheme.glassElevated,
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      GlassButton(
                        icon: Icons.close_rounded,
                        variant: GlassButtonVariant.icon,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  body,
                  if (actions != null) ...[
                    const SizedBox(height: 24),
                    const Divider(color: LiquidGlassTheme.glassBorder),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: actions!
                          .map(
                            (a) => Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: GlassButton(
                                label: a.label,
                                onPressed: a.onTap,
                                accentColor: a.color,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Toast notification overlay entry
class GlassToast {
  static OverlayEntry? _entry;

  static void show(
    BuildContext context, {
    required String message,
    IconData icon = Icons.check_circle_rounded,
    Color color = LiquidGlassTheme.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    _entry?.remove();

    final overlay = Overlay.of(context);
    final controller = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 400),
    );

    _entry = OverlayEntry(
      builder: (ctx) => _GlassToastWidget(
        message: message,
        icon: icon,
        color: color,
        controller: controller,
      ),
    );

    overlay.insert(_entry!);
    controller.forward();

    Future.delayed(duration, () {
      controller.reverse().then((_) {
        _entry?.remove();
        _entry = null;
        controller.dispose();
      });
    });
  }
}

class _GlassToastWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color color;
  final AnimationController controller;

  const _GlassToastWidget({
    required this.message,
    required this.icon,
    required this.color,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80,
      left: 0,
      right: 0,
      child: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            final curve = CurvedAnimation(parent: controller, curve: Curves.easeOutBack);
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -1.5),
                end: Offset.zero,
              ).animate(curve),
              child: FadeTransition(
                opacity: controller,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(LiquidGlassTheme.radiusPill),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(LiquidGlassTheme.radiusPill),
                        color: color.withOpacity(0.15),
                        border: Border.all(
                          color: color.withOpacity(0.4),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.25),
                            blurRadius: 20,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(icon, color: color, size: 20),
                          const SizedBox(width: 10),
                          Text(
                            message,
                            style: const TextStyle(
                              color: LiquidGlassTheme.textPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
