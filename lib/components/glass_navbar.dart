import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';

class GlassNavbar extends StatelessWidget {
  final String title;
  final List<_NavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final List<Widget>? actions;

  const GlassNavbar({
    super.key,
    required this.title,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 64,
          decoration: const BoxDecoration(
            color: Color(0x1AFFFFFF),
            border: Border(
              bottom: BorderSide(color: LiquidGlassTheme.glassBorder, width: 1),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              // Logo
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [LiquidGlassTheme.accent, LiquidGlassTheme.accentViolet],
                ).createShader(bounds),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              const SizedBox(width: 32),
              // Nav items
              Expanded(
                child: Row(
                  children: items.asMap().entries.map((e) {
                    final isSelected = e.key == selectedIndex;
                    return _NavPill(
                      item: e.value,
                      isSelected: isSelected,
                      onTap: () => onItemSelected(e.key),
                    );
                  }).toList(),
                ),
              ),
              // Actions
              if (actions != null) ...actions!,
            ],
          ),
        ),
      ),
    );
  }
}

class _NavPill extends StatefulWidget {
  final _NavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavPill({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavPill> createState() => _NavPillState();
}

class _NavPillState extends State<_NavPill> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(right: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LiquidGlassTheme.radiusPill),
            color: widget.isSelected
                ? LiquidGlassTheme.accent.withOpacity(0.2)
                : _hovered
                    ? Colors.white.withOpacity(0.08)
                    : Colors.transparent,
            border: Border.all(
              color: widget.isSelected
                  ? LiquidGlassTheme.accent.withOpacity(0.5)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.item.icon,
                size: 16,
                color: widget.isSelected
                    ? LiquidGlassTheme.accent
                    : LiquidGlassTheme.textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                widget.item.label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: widget.isSelected
                          ? LiquidGlassTheme.accent
                          : LiquidGlassTheme.textSecondary,
                      fontWeight: widget.isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  const _NavItem(this.label, this.icon);
}

List<_NavItem> navItems(List<({String label, IconData icon})> data) {
  return data.map((d) => _NavItem(d.label, d.icon)).toList();
}
