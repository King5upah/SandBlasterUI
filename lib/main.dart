import 'package:flutter/material.dart';
import 'theme/liquid_glass_theme.dart';
import 'widgets/animated_background.dart';
import 'screens/gallery_screen.dart';

void main() {
  runApp(const LiquidGlassApp());
}

enum SandblasterThemeMode { dark, light, ruby, latte }

class ThemeController extends ChangeNotifier {
  SandblasterThemeMode _mode = SandblasterThemeMode.dark;
  SandblasterThemeMode get mode => _mode;

  void setMode(SandblasterThemeMode newMode) {
    if (_mode != newMode) {
      _mode = newMode;
      notifyListeners();
    }
  }
}

class ThemeProvider extends InheritedNotifier<ThemeController> {
  const ThemeProvider({
    super.key,
    required ThemeController super.notifier,
    required super.child,
  });

  static ThemeController of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!.notifier!;
  }
}

class LiquidGlassApp extends StatefulWidget {
  const LiquidGlassApp({super.key});

  @override
  State<LiquidGlassApp> createState() => _LiquidGlassAppState();
}

class _LiquidGlassAppState extends State<LiquidGlassApp> {
  final ThemeController _themeController = ThemeController();

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      notifier: _themeController,
      child: ListenableBuilder(
        listenable: _themeController,
        builder: (context, child) {
          ThemeData activeTheme;
          switch (_themeController.mode) {
            case SandblasterThemeMode.light:
              activeTheme = LiquidGlassTheme.lightTheme;
              break;
            case SandblasterThemeMode.ruby:
              activeTheme = LiquidGlassTheme.rubyTheme;
              break;
            case SandblasterThemeMode.latte:
              activeTheme = LiquidGlassTheme.latteTheme;
              break;
            default:
              activeTheme = LiquidGlassTheme.darkTheme;
              break;
          }

          return MaterialApp(
            title: 'Sandblaster — Flutter Web Design System',
            debugShowCheckedModeBanner: false,
            theme: activeTheme,
            home: const _RootShell(),
          );
        },
      ),
    );
  }
}

class _RootShell extends StatelessWidget {
  const _RootShell();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: GalleryScreen(),
    );
  }
}
