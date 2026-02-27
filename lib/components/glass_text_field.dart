import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';
import '../widgets/liquid_glass_container.dart';

class GlassTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool showShadow;

  const GlassTextField({
    super.key,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.showShadow = true,
  });

  @override
  State<GlassTextField> createState() => _GlassTextFieldState();
}

class _GlassTextFieldState extends State<GlassTextField>
    with SingleTickerProviderStateMixin {
  final _focus = FocusNode();
  bool _focused = false;
  late AnimationController _glowController;
  late Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _glowAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeOut),
    );
    _focus.addListener(() {
      setState(() => _focused = _focus.hasFocus);
      if (_focus.hasFocus) {
        _glowController.forward();
      } else {
        _glowController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnim,
      builder: (ctx, _) {
        return LiquidGlassContainer(
          showShadow: widget.showShadow,
          borderRadius: LiquidGlassTheme.radiusMd,
          padding: EdgeInsets.zero,
          surfaceColor: _focused
              ? context.sbTheme.accent.withValues(alpha: 0.08)
              : context.sbTheme.glassSurface,
          borderColor: _focused
              ? context.sbTheme.accent.withValues(alpha: 0.6)
              : context.sbTheme.glassBorder,
          shadowOverride: _focused ? BoxShadow(
            color: context.sbTheme.accent.withValues(alpha: 0.3 * _glowAnim.value),
            blurRadius: 20 * _glowAnim.value,
            spreadRadius: 2 * _glowAnim.value,
          ) : null,
          child: TextField(
            focusNode: _focus,
            controller: widget.controller,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            style: TextStyle(color: context.sbTheme.textPrimary),
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hint,
              labelStyle: TextStyle(
                color: _focused
                    ? context.sbTheme.accent
                    : context.sbTheme.textSecondary,
              ),
              hintStyle: TextStyle(color: context.sbTheme.textTertiary),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: _focused
                          ? context.sbTheme.accent
                          : context.sbTheme.textSecondary,
                      size: 20,
                    )
                  : null,
              suffixIcon: widget.suffixIcon != null
                  ? Icon(
                      widget.suffixIcon,
                      color: context.sbTheme.textSecondary,
                      size: 20,
                    )
                  : null,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}
