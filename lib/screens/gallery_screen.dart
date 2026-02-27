import 'package:flutter/material.dart';
import '../../theme/liquid_glass_theme.dart';
import '../../widgets/liquid_glass_container.dart';
import '../../components/glass_button.dart';
import '../../components/glass_card.dart';
import '../../components/glass_text_field.dart';
import '../../components/glass_toggle_chip.dart';
import '../../components/glass_slider_tab.dart';
import '../../components/glass_modal_toast.dart';
import '../../components/glass_checkbox_radio.dart';
import '../../components/glass_dropdown.dart';
import '../widgets/animated_background.dart';
import '../../main.dart';
import 'dart:ui';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  int _sidebarIndex = 0;
  bool _sidebarOpen = true;
  bool _animatedBg = true; // New state variable

  final _sections = [
    'Overview',
    'Buttons',
    'Cards',
    'Inputs',
    'Toggles & Chips',
    'Sliders & Tabs',
    'Modals & Toasts',
    'Surfaces',
  ];

  final _sectionIcons = [
    Icons.dashboard_rounded,
    Icons.smart_button_rounded,
    Icons.crop_landscape_rounded,
    Icons.text_fields_rounded,
    Icons.toggle_on_rounded,
    Icons.tune_rounded,
    Icons.layers_rounded,
    Icons.blur_on_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final content = Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          // Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            width: _sidebarOpen ? 240 : 0,
            child: _sidebarOpen ? _Sidebar(
              sections: _sections,
              icons: _sectionIcons,
              selectedIndex: _sidebarIndex,
              onSectionSelected: (i) => setState(() => _sidebarIndex = i),
            ) : null,
          ),
          // Main content
          Expanded(
            child: Column(
              children: [
                // Header
                _Header(
                  sidebarOpen: _sidebarOpen,
                  onToggleSidebar: () => setState(() => _sidebarOpen = !_sidebarOpen),
                  currentSection: _sections[_sidebarIndex],
                  animatedBg: _animatedBg,
                  onToggleBg: () => setState(() => _animatedBg = !_animatedBg),
                ),
                // Body
                Expanded(
                  child: _SectionView(sectionIndex: _sidebarIndex),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return _animatedBg 
        ? AnimatedBackground(child: content)
        : Container(
            color: context.sbTheme.bgDeep, // The tuned plain backgrounds
            child: content,
          );
  }
}

class _Sidebar extends StatelessWidget {
  final List<String> sections;
  final List<IconData> icons;
  final int selectedIndex;
  final ValueChanged<int> onSectionSelected;

  const _Sidebar({
    required this.sections,
    required this.icons,
    required this.selectedIndex,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0x12FFFFFF),
            border: Border(
              right: BorderSide(color: context.sbTheme.glassBorder, width: 1),
            ),
          ),
          child: Column(
            children: [
              // Logo
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [context.sbTheme.accent, context.sbTheme.accentViolet],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: context.sbTheme.accent.withValues(alpha: 0.4),
                            blurRadius: 12,
                          )
                        ],
                      ),
                      child: const Icon(Icons.water_drop_rounded, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShaderMask(
                          shaderCallback: (b) => LinearGradient(
                            colors: [context.sbTheme.accent, context.sbTheme.accentViolet],
                          ).createShader(b),
                          child: const Text(
                            'Sandblaster',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          'UI Design System',
                          style: TextStyle(
                            fontSize: 11,
                            color: context.sbTheme.textTertiary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Divider(color: context.sbTheme.glassBorder, height: 1),
              const SizedBox(height: 12),
              // Navigation items
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  itemCount: sections.length,
                  itemBuilder: (ctx, i) {
                    final isSelected = i == selectedIndex;
                    return _SidebarItem(
                      label: sections[i],
                      icon: icons[i],
                      isSelected: isSelected,
                      onTap: () => onSectionSelected(i),
                    );
                  },
                ),
              ),
              // Footer
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.flutter_dash, color: context.sbTheme.accent, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Flutter Web · 2025',
                      style: TextStyle(
                        fontSize: 11,
                        color: context.sbTheme.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SidebarItem extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
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
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LiquidGlassTheme.radiusSm),
            color: widget.isSelected
                ? context.sbTheme.accent.withValues(alpha: 0.15)
                : _hovered
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.transparent,
            border: Border.all(
              color: widget.isSelected
                  ? context.sbTheme.accent.withValues(alpha: 0.3)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 18,
                color: widget.isSelected
                    ? context.sbTheme.accent
                    : context.sbTheme.textSecondary,
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: widget.isSelected
                      ? context.sbTheme.accent
                      : context.sbTheme.textSecondary,
                ),
              ),
              if (widget.isSelected) ...[
                const Spacer(),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.sbTheme.accent,
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

class _Header extends StatelessWidget {
  final bool sidebarOpen;
  final VoidCallback onToggleSidebar;
  final String currentSection;
  final bool animatedBg;
  final VoidCallback onToggleBg;

  const _Header({
    required this.sidebarOpen,
    required this.onToggleSidebar,
    required this.currentSection,
    required this.animatedBg,
    required this.onToggleBg,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0x0FFFFFFF),
            border: Border(
              bottom: BorderSide(color: context.sbTheme.glassBorder),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              GlassButton(
                icon: sidebarOpen ? Icons.menu_open_rounded : Icons.menu_rounded,
                variant: GlassButtonVariant.icon,
                onPressed: onToggleSidebar,
              ),
              const SizedBox(width: 16),
              Text(
                currentSection,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.sbTheme.success.withValues(alpha: 0.15),
                  border: Border.all(color: context.sbTheme.success.withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.sbTheme.success,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'v1.4.1',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.sbTheme.success,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              GlassButton(
                icon: animatedBg ? Icons.motion_photos_on_rounded : Icons.motion_photos_paused_rounded,
                variant: GlassButtonVariant.icon,
                accentColor: animatedBg ? context.sbTheme.orbBlue : context.sbTheme.textSecondary,
                onPressed: onToggleBg,
              ),
              const SizedBox(width: 8),
              GlassButton(
                icon: Icons.palette_rounded,
                variant: GlassButtonVariant.icon,
                accentColor: context.sbTheme.orbPink,
                onPressed: () {
                  final ctrl = ThemeProvider.of(context);
                  final nextMode = SandblasterThemeMode.values[(ctrl.mode.index + 1) % SandblasterThemeMode.values.length];
                  ctrl.setMode(nextMode);
                },
              ),
              const SizedBox(width: 8),
              const GlassButton(
                icon: Icons.code_rounded,
                variant: GlassButtonVariant.icon,
              ),
              const SizedBox(width: 8),
              GlassButton(
                icon: Icons.star_rounded,
                variant: GlassButtonVariant.icon,
                accentColor: context.sbTheme.warning,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionView extends StatefulWidget {
  final int sectionIndex;
  const _SectionView({required this.sectionIndex});

  @override
  State<_SectionView> createState() => _SectionViewState();
}

class _SectionViewState extends State<_SectionView> {
  // State for interactive demos
  bool _toggle1 = true;
  bool _toggle2 = false;
  bool _toggle3 = true;
  double _sliderVal = 0.6;
  double _sliderVal2 = 0.3;
  int _tabIndex = 0;
  final _textCtrl = TextEditingController();
  
  // New input states
  int _radioVal = 1;
  bool _check1 = false;
  bool _check2 = true;
  String _dropdownVal = 'option1';

  final _tabs = ['Design', 'Components', 'Motion', 'Colors'];

  Widget _buildSection(String title, String subtitle, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 4),
        Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 24),
        content,
      ],
    );
  }

  Widget _demoBox({required Widget child, Color? bg}) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LiquidGlassTheme.radiusLg),
        color: bg ?? Colors.white.withValues(alpha: 0.03),
        border: Border.all(color: context.sbTheme.glassBorder),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, anim) => FadeTransition(
        opacity: anim,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.02, 0),
            end: Offset.zero,
          ).animate(anim),
          child: child,
        ),
      ),
      child: KeyedSubtree(
        key: ValueKey(widget.sectionIndex),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (widget.sectionIndex) {
      case 0:
        return _buildOverview();
      case 1:
        return _buildButtons();
      case 2:
        return _buildCards();
      case 3:
        return _buildInputs();
      case 4:
        return _buildTogglesChips();
      case 5:
        return _buildSlidersTabs();
      case 6:
        return _buildModalsToasts();
      case 7:
        return _buildSurfaces();
      default:
        return _buildOverview();
    }
  }

  Widget _buildOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero
        LiquidGlassContainer(
          blur: LiquidGlassTheme.blurHeavy,
          borderRadius: LiquidGlassTheme.radiusXl,
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [context.sbTheme.accent, context.sbTheme.accentViolet],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: context.sbTheme.accent.withValues(alpha: 0.5),
                          blurRadius: 20,
                        )
                      ],
                    ),
                    child: const Icon(Icons.water_drop_rounded, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (b) => LinearGradient(
                          colors: [Colors.white, context.sbTheme.accent, context.sbTheme.accentViolet],
                        ).createShader(b),
                        child: Text(
                          'Sandblaster',
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                color: Colors.white,
                                fontSize: 42,
                              ),
                        ),
                      ),
                      Text(
                        'UI Design System for Flutter Web',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: context.sbTheme.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'A premium Flutter Web component library built around glass-inspired aesthetics. '
                'Sandblaster brings translucent surfaces, specular highlights, lensing effects, '
                'and fluid physics-based animations natively to Flutter Web.',
              // style inspired by Apple\'s Liquid Glass design language (WWDC 2025)
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
              ),
              const SizedBox(height: 28),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  GlassChip(label: 'BackdropFilter', icon: Icons.blur_on_rounded, color: context.sbTheme.accent),
                  GlassChip(label: 'Specular Highlights', icon: Icons.light_mode_rounded, color: context.sbTheme.accentViolet),
                  GlassChip(label: 'Physics Motion', icon: Icons.animation_rounded, color: context.sbTheme.orbCyan),
                  GlassChip(label: 'Adaptive Color', icon: Icons.palette_rounded, color: context.sbTheme.orbPink),
                  GlassChip(label: 'Flutter Web', icon: Icons.flutter_dash, color: context.sbTheme.orbEmerald),
                ],
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  GlassButton(
                    label: 'Explore Components',
                    icon: Icons.explore_rounded,
                    accentColor: context.sbTheme.accent,
                  ),
                  const SizedBox(width: 12),
                  GlassButton(
                    label: 'View Source',
                    icon: Icons.code_rounded,
                    variant: GlassButtonVariant.ghost,
                    accentColor: context.sbTheme.textSecondary,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        // Stats
        Row(
          children: [
            Expanded(child: _StatCard(label: 'Components', value: '12+', icon: Icons.widgets_rounded, color: context.sbTheme.accent)),
            const SizedBox(width: 16),
            Expanded(child: _StatCard(label: 'Animations', value: '∞', icon: Icons.animation_rounded, color: context.sbTheme.accentViolet)),
            const SizedBox(width: 16),
            Expanded(child: _StatCard(label: 'Glass Layers', value: '3', icon: Icons.layers_rounded, color: context.sbTheme.orbCyan)),
            const SizedBox(width: 16),
            Expanded(child: _StatCard(label: 'Blur Levels', value: '3', icon: Icons.blur_on_rounded, color: context.sbTheme.orbPink)),
          ],
        ),
        const SizedBox(height: 32),
        // Design principles
        _buildSection(
          'Design Principles',
          'The foundation of Sandblaster — clarity, depth, and deference.',
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _PrincipleCard(
                icon: Icons.water_rounded,
                label: 'Translucency',
                desc: 'Dynamic frosted glass surfaces that reveal context beneath',
                color: context.sbTheme.accent,
              ),
              _PrincipleCard(
                icon: Icons.highlight_rounded,
                label: 'Specular Light',
                desc: 'Real-time light reflections that respond to interaction',
                color: context.sbTheme.accentViolet,
              ),
              _PrincipleCard(
                icon: Icons.animation_rounded,
                label: 'Fluid Motion',
                desc: 'Physics-based animations with Apple-inspired easing curves',
                color: context.sbTheme.orbCyan,
              ),
              _PrincipleCard(
                icon: Icons.palette_rounded,
                label: 'Adaptive Color',
                desc: 'Components intelligently adapt to their surroundings',
                color: context.sbTheme.orbPink,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return _buildSection(
      'Buttons',
      'Interactive glass buttons with hover animations and ripple effects.',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _demoBox(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                GlassButton(
                  label: 'Primary',
                  icon: Icons.star_rounded,
                  accentColor: context.sbTheme.accent,
                ),
                GlassButton(
                  label: 'Violet',
                  icon: Icons.auto_awesome_rounded,
                  accentColor: context.sbTheme.accentViolet,
                ),
                GlassButton(
                  label: 'Success',
                  icon: Icons.check_rounded,
                  accentColor: context.sbTheme.success,
                ),
                GlassButton(
                  label: 'Warning',
                  icon: Icons.warning_amber_rounded,
                  accentColor: context.sbTheme.warning,
                ),
                GlassButton(
                  label: 'Danger',
                  icon: Icons.delete_rounded,
                  accentColor: context.sbTheme.error,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _demoBox(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                GlassButton(
                  label: 'Ghost',
                  variant: GlassButtonVariant.ghost,
                  accentColor: context.sbTheme.accent,
                ),
                GlassButton(
                  label: 'Ghost Violet',
                  variant: GlassButtonVariant.ghost,
                  accentColor: context.sbTheme.accentViolet,
                ),
                GlassButton(
                  icon: Icons.favorite_rounded,
                  variant: GlassButtonVariant.icon,
                  accentColor: context.sbTheme.error,
                ),
                GlassButton(
                  icon: Icons.share_rounded,
                  variant: GlassButtonVariant.icon,
                  accentColor: context.sbTheme.accent,
                ),
                GlassButton(
                  icon: Icons.bookmark_rounded,
                  variant: GlassButtonVariant.icon,
                  accentColor: context.sbTheme.warning,
                ),
                GlassButton(
                  label: 'Loading...',
                  loading: true,
                  accentColor: context.sbTheme.orbCyan,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCards() {
    return _buildSection(
      'Cards',
      'Layered glass surfaces with contextual elevation and hover effects.',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              GlassCard(
                title: 'Sandblaster Card',
                subtitle: 'With specular highlight',
                leadingIcon: Icons.water_drop_rounded,
                accentColor: context.sbTheme.accent,
                width: 300,
                child: Text(
                  'A frosted glass surface with real-time backdrop blur and '
                  'specular light reflection at the top edge.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              GlassCard(
                title: 'Stats Overview',
                subtitle: 'System metrics',
                leadingIcon: Icons.insights_rounded,
                accentColor: context.sbTheme.orbCyan,
                width: 300,
                trailing: GlassChip(label: 'Live', color: context.sbTheme.success),
                child: Column(
                  children: [
                    _MetricRow(label: 'FPS', value: '60', color: context.sbTheme.success),
                    _MetricRow(label: 'Blur Sigma', value: '20px', color: context.sbTheme.accent),
                    _MetricRow(label: 'Opacity', value: '18%', color: context.sbTheme.accentViolet),
                  ],
                ),
              ),
              GlassCard(
                title: 'Notification',
                subtitle: 'Glass surface elevated',
                leadingIcon: Icons.notifications_rounded,
                accentColor: context.sbTheme.accentViolet,
                width: 300,
                onTap: () {},
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Your design system is ready. Tap to view the full component library.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded, color: context.sbTheme.textTertiary),
                  ],
                ),
              ),
              GlassCard(
                title: 'Interactive Card',
                subtitle: 'Hover to lift',
                leadingIcon: Icons.touch_app_rounded,
                accentColor: context.sbTheme.orbPink,
                width: 300,
                onTap: () => GlassToast.show(
                  context,
                  message: 'Card tapped!',
                  icon: Icons.touch_app_rounded,
                  color: context.sbTheme.orbPink,
                ),
                child: Text(
                  'This card is interactive. Hover for a lift effect, tap to trigger a toast.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputs() {
    return _buildSection(
      'Form Inputs',
      'Glass-frosted text fields, dropdowns, checkboxes, and radio buttons.',
      Column(
        children: [
          _demoBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Text Fields', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 16),
                GlassTextField(
                  label: 'Email address',
                  hint: 'you@example.com',
                  prefixIcon: Icons.email_rounded,
                  suffixIcon: Icons.check_circle_rounded,
                  controller: _textCtrl,
                ),
                const SizedBox(height: 16),
                const GlassTextField(
                  label: 'Password',
                  hint: '••••••••',
                  prefixIcon: Icons.lock_rounded,
                  suffixIcon: Icons.visibility_rounded,
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                const GlassTextField(
                  label: 'Search',
                  hint: 'Search components...',
                  prefixIcon: Icons.search_rounded,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _demoBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dropdown', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 16),
                      GlassDropdown<String>(
                        value: _dropdownVal,
                        items: const [
                          DropdownMenuItem(value: 'option1', child: Text('Design System')),
                          DropdownMenuItem(value: 'option2', child: Text('Components')),
                          DropdownMenuItem(value: 'option3', child: Text('Motion & Physics')),
                        ],
                        onChanged: (v) => setState(() => _dropdownVal = v ?? 'option1'),
                        hint: 'Select an option',
                        prefixIcon: Icons.layers_rounded,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Checkbox & Radio', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 16),
                      GlassCheckbox(
                        value: _check1,
                        label: 'Enable fluid motion physics',
                        onChanged: (v) => setState(() => _check1 = v),
                      ),
                      const SizedBox(height: 8),
                      GlassCheckbox(
                        value: _check2,
                        label: 'Use volumetric glass shadows',
                        onChanged: (v) => setState(() => _check2 = v),
                        activeColor: context.sbTheme.orbCyan,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        children: [
                          GlassRadio<int>(
                            value: 1,
                            groupValue: _radioVal,
                            onChanged: (v) => setState(() => _radioVal = v),
                            label: 'Light Blur',
                          ),
                          GlassRadio<int>(
                            value: 2,
                            groupValue: _radioVal,
                            onChanged: (v) => setState(() => _radioVal = v),
                            label: 'Heavy Blur',
                            activeColor: context.sbTheme.orbPink,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTogglesChips() {
    return _buildSection(
      'Toggles & Chips',
      'Liquid toggle switches and glass pill chips with color variants.',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _demoBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Toggles', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 16),
                _ToggleRow(
                  label: 'Notifications',
                  value: _toggle1,
                  onChanged: (v) => setState(() => _toggle1 = v),
                ),
                const SizedBox(height: 12),
                _ToggleRow(
                  label: 'Dark Mode',
                  value: _toggle2,
                  onChanged: (v) => setState(() => _toggle2 = v),
                  color: context.sbTheme.accentViolet,
                ),
                const SizedBox(height: 12),
                _ToggleRow(
                  label: 'Haptic Feedback',
                  value: _toggle3,
                  onChanged: (v) => setState(() => _toggle3 = v),
                  color: context.sbTheme.orbCyan,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _demoBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Chips & Badges', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    GlassChip(label: 'Active', color: context.sbTheme.success, icon: Icons.circle),
                    GlassChip(label: 'Pending', color: context.sbTheme.warning, icon: Icons.hourglass_empty_rounded),
                    GlassChip(label: 'Error', color: context.sbTheme.error, icon: Icons.error_rounded),
                    GlassChip(label: 'Flutter', color: context.sbTheme.accent, icon: Icons.flutter_dash),
                    GlassChip(label: 'Design', color: context.sbTheme.accentViolet, icon: Icons.design_services_rounded),
                    GlassChip(label: 'Outlined', outlined: true, color: context.sbTheme.orbCyan),
                    GlassChip(label: 'Outlined', outlined: true, color: context.sbTheme.orbPink),
                    const GlassChip(label: 'Glass', outlined: true, color: Colors.white),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlidersTabs() {
    return _buildSection(
      'Sliders & Tabs',
      'Glass sliders with liquid fill effects and animated tab pills.',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _demoBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sliders', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 20),
                _SliderRow(
                  label: 'Volume',
                  icon: Icons.volume_up_rounded,
                  value: _sliderVal,
                  color: context.sbTheme.accent,
                  onChanged: (v) => setState(() => _sliderVal = v),
                ),
                const SizedBox(height: 16),
                _SliderRow(
                  label: 'Blur Intensity',
                  icon: Icons.blur_on_rounded,
                  value: _sliderVal2,
                  color: context.sbTheme.accentViolet,
                  onChanged: (v) => setState(() => _sliderVal2 = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _demoBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tab Bar', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 16),
                GlassTabBar(
                  tabs: _tabs,
                  selectedIndex: _tabIndex,
                  onChanged: (i) => setState(() => _tabIndex = i),
                ),
                const SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    key: ValueKey(_tabIndex),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(LiquidGlassTheme.radiusMd),
                      color: Colors.white.withValues(alpha: 0.04),
                      border: Border.all(color: context.sbTheme.glassBorder),
                    ),
                    child: Text(
                      _tabContent[_tabIndex],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final _tabContent = [
    'Liquid Glass design builds on Apple\'s WWDC 2025 design language, '
        'creating translucent surfaces that feel alive and responsive. '
        'The design emphasizes clarity, deference, and depth.',
    'Each component implements BackdropFilter with ImageFilter.blur for real frosted glass. '
        'Custom painters add specular highlights, gradient borders, and shimmer effects '
        'that react to mouse position.',
    'Animations use physics-based curves (easeInOutCubic, easeOutBack) for natural feel. '
        'AnimationController with repeat/reverse creates breathing effects. '
        'Flutter Animate adds stagger and entry animations.',
    'The palette uses deep navy/indigo backgrounds with iridescent accent tones. '
        'Colored glass is achieved via color.withValues(alpha: ) over BackdropFilter, '
        'letting background content tint the surface.',
  ];

  Widget _buildModalsToasts() {
    return _buildSection(
      'Modals & Toasts',
      'Animated modal dialogs and toast notifications with glass frosting.',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _demoBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dialog Modals', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    GlassButton(
                      label: 'Open Modal',
                      icon: Icons.open_in_new_rounded,
                      accentColor: context.sbTheme.accent,
                      onPressed: () => GlassModal.show(
                        context,
                        title: 'Liquid Glass Modal',
                        body: Text(
                          'This modal uses a BackdropFilter blur for the background + '
                          'slide+fade transition. The glass surface adapts to the content below it.',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
                        ),
                        actions: [
                          (label: 'Cancel', color: context.sbTheme.textSecondary, onTap: () => Navigator.pop(context)),
                          (label: 'Confirm', color: context.sbTheme.accent, onTap: () => Navigator.pop(context)),
                        ],
                      ),
                    ),
                    GlassButton(
                      label: 'Delete Modal',
                      icon: Icons.delete_rounded,
                      accentColor: context.sbTheme.error,
                      onPressed: () => GlassModal.show(
                        context,
                        title: 'Delete Component?',
                        body: Text(
                          'This action cannot be undone. The component and all associated data will be permanently removed.',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
                        ),
                        actions: [
                          (label: 'Cancel', color: context.sbTheme.textSecondary, onTap: () => Navigator.pop(context)),
                          (label: 'Delete', color: context.sbTheme.error, onTap: () => Navigator.pop(context)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _demoBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Toast Notifications', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    GlassButton(
                      label: 'Success',
                      icon: Icons.check_circle_rounded,
                      accentColor: context.sbTheme.success,
                      onPressed: () => GlassToast.show(
                        context,
                        message: 'Component saved successfully!',
                        icon: Icons.check_circle_rounded,
                        color: context.sbTheme.success,
                      ),
                    ),
                    GlassButton(
                      label: 'Warning',
                      icon: Icons.warning_rounded,
                      accentColor: context.sbTheme.warning,
                      onPressed: () => GlassToast.show(
                        context,
                        message: 'Blur intensity is very high',
                        icon: Icons.warning_rounded,
                        color: context.sbTheme.warning,
                      ),
                    ),
                    GlassButton(
                      label: 'Error',
                      icon: Icons.error_rounded,
                      accentColor: context.sbTheme.error,
                      onPressed: () => GlassToast.show(
                        context,
                        message: 'Failed to load component',
                        icon: Icons.error_rounded,
                        color: context.sbTheme.error,
                      ),
                    ),
                    GlassButton(
                      label: 'Info',
                      icon: Icons.info_rounded,
                      accentColor: context.sbTheme.accent,
                      onPressed: () => GlassToast.show(
                        context,
                        message: 'New components available!',
                        icon: Icons.info_rounded,
                        color: context.sbTheme.accent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurfaces() {
    return _buildSection(
      'Glass Surfaces',
      'Raw glass surface primitives with different blur and opacity levels.',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              const _SurfaceSample(
                label: 'Light (8px)',
                blur: LiquidGlassTheme.blurLight,
                opacity: 0.10,
              ),
              const _SurfaceSample(
                label: 'Medium (20px)',
                blur: LiquidGlassTheme.blurMedium,
                opacity: 0.18,
              ),
              const _SurfaceSample(
                label: 'Heavy (40px)',
                blur: LiquidGlassTheme.blurHeavy,
                opacity: 0.28,
              ),
              _SurfaceSample(
                label: 'Tinted Blue',
                blur: LiquidGlassTheme.blurMedium,
                opacity: 0.18,
                tint: context.sbTheme.accent.withValues(alpha: 0.15),
              ),
              _SurfaceSample(
                label: 'Tinted Violet',
                blur: LiquidGlassTheme.blurMedium,
                opacity: 0.18,
                tint: context.sbTheme.accentViolet.withValues(alpha: 0.15),
              ),
              _SurfaceSample(
                label: 'Tinted Cyan',
                blur: LiquidGlassTheme.blurMedium,
                opacity: 0.18,
                tint: context.sbTheme.orbCyan.withValues(alpha: 0.15),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildSection(
            'Token Reference',
            'Design tokens used across all Liquid Glass components.',
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                const _TokenCard(name: 'bgDeep', value: '#050814', color: Color(0xFF050814)),
                _TokenCard(name: 'accent', value: '#60A5FA', color: context.sbTheme.accent),
                _TokenCard(name: 'accentViolet', value: '#A78BFA', color: context.sbTheme.accentViolet),
                _TokenCard(name: 'success', value: '#34D399', color: context.sbTheme.success),
                _TokenCard(name: 'warning', value: '#FBBF24', color: context.sbTheme.warning),
                _TokenCard(name: 'error', value: '#F87171', color: context.sbTheme.error),
                _TokenCard(name: 'orbBlue', value: '#3B82F6', color: context.sbTheme.orbBlue),
                _TokenCard(name: 'orbViolet', value: '#7C3AED', color: context.sbTheme.orbViolet),
                _TokenCard(name: 'orbCyan', value: '#06B6D4', color: context.sbTheme.orbCyan),
                _TokenCard(name: 'orbPink', value: '#EC4899', color: context.sbTheme.orbPink),
                _TokenCard(name: 'orbEmerald', value: '#10B981', color: context.sbTheme.orbEmerald),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widgets

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LiquidGlassContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 32,
                  color: color,
                ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}

class _PrincipleCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String desc;
  final Color color;

  const _PrincipleCard({
    required this.icon,
    required this.label,
    required this.desc,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LiquidGlassContainer(
      width: 240,
      padding: const EdgeInsets.all(20),
      interactive: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color.withValues(alpha: 0.15),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 12),
          Text(label, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(
            desc,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MetricRow({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: color.withValues(alpha: 0.15),
            ),
            child: Text(
              value,
              style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? color;

  const _ToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          value ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
          color: color ?? context.sbTheme.accent,
          size: 18,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.bodyLarge),
        ),
        GlassToggle(value: value, onChanged: onChanged, activeTrackColor: color),
      ],
    );
  }
}

class _SliderRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final double value;
  final Color color;
  final ValueChanged<double> onChanged;

  const _SliderRow({
    required this.label,
    required this.icon,
    required this.value,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(label, style: Theme.of(context).textTheme.bodyMedium),
                  const Spacer(),
                  Text(
                    '${(value * 100).round()}%',
                    style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ],
              ),
              GlassSlider(
                value: value,
                onChanged: onChanged,
                activeColor: color,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SurfaceSample extends StatelessWidget {
  final String label;
  final double blur;
  final double opacity;
  final Color? tint;

  const _SurfaceSample({
    required this.label,
    required this.blur,
    required this.opacity,
    this.tint,
  });

  @override
  Widget build(BuildContext context) {
    return LiquidGlassContainer(
      width: 180,
      height: 120,
      blur: blur,
      surfaceColor: tint ?? Colors.white.withValues(alpha: opacity),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            label,
            style: TextStyle(
              color: context.sbTheme.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          Text(
            'blur: ${blur.toStringAsFixed(0)}px',
            style: TextStyle(
              color: context.sbTheme.textTertiary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _TokenCard extends StatelessWidget {
  final String name;
  final String value;
  final Color color;

  const _TokenCard({required this.name, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LiquidGlassTheme.radiusMd),
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(color: context.sbTheme.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: color,
              boxShadow: [BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 8)],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              color: context.sbTheme.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: context.sbTheme.textTertiary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}