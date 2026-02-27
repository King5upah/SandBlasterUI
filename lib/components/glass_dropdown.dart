import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';
import '../widgets/liquid_glass_container.dart';

class GlassDropdown<T> extends StatefulWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final IconData? prefixIcon;
  final bool showShadow;

  const GlassDropdown({
    super.key,
    required this.value,
    required this.items,
    this.onChanged,
    this.hint,
    this.prefixIcon,
    this.showShadow = true,
  });

  @override
  State<GlassDropdown> createState() => _GlassDropdownState<T>();
}

class _GlassDropdownState<T> extends State<GlassDropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _showDropdown();
    }
  }

  void _showDropdown() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: _closeDropdown,
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.transparent,
              ),
            ),
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height + 8,
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, size.height + 8),
                child: Material(
                  color: Colors.transparent,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, -10 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: LiquidGlassContainer(
                      showShadow: widget.showShadow,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      borderRadius: LiquidGlassTheme.radiusMd,
                      blur: LiquidGlassTheme.blurHeavy,
                      surfaceColor: context.sbTheme.glassElevated,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: widget.items.map((item) {
                          final isSelected = item.value == widget.value;
                          return GestureDetector(
                            onTap: () {
                              widget.onChanged?.call(item.value);
                              _closeDropdown();
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                color: isSelected 
                                    ? context.sbTheme.accent.withValues(alpha: 0.15) 
                                    : Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                child: item,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DropdownMenuItem<T>? selectedItem;
    try {
      selectedItem = widget.items.firstWhere((item) => item.value == widget.value);
    } catch (_) {}

    return CompositedTransformTarget(
      link: _layerLink,
      child: LiquidGlassContainer(
        showShadow: widget.showShadow,
        borderRadius: LiquidGlassTheme.radiusMd,
        interactive: true,
        onTap: _toggleDropdown,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        surfaceColor: _isOpen
            ? context.sbTheme.accent.withValues(alpha: 0.08)
            : context.sbTheme.glassSurface,
        borderColor: _isOpen
            ? context.sbTheme.accent.withValues(alpha: 0.6)
            : context.sbTheme.glassBorder,
        child: Row(
          children: [
            if (widget.prefixIcon != null) ...[
              Icon(
                widget.prefixIcon,
                color: _isOpen ? context.sbTheme.accent : context.sbTheme.textSecondary,
                size: 20,
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: selectedItem != null
                  ? selectedItem.child
                  : Text(
                      widget.hint ?? '',
                      style: TextStyle(color: context.sbTheme.textTertiary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
            AnimatedRotation(
              turns: _isOpen ? 0.5 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: context.sbTheme.textSecondary,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
