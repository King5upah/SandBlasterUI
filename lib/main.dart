import 'package:flutter/material.dart';
import 'theme/liquid_glass_theme.dart';
import 'widgets/animated_background.dart';
import 'screens/gallery_screen.dart';

void main() {
  runApp(const LiquidGlassApp());
}

class LiquidGlassApp extends StatelessWidget {
  const LiquidGlassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liquid Glass — Flutter Web Design System',
      debugShowCheckedModeBanner: false,
      theme: LiquidGlassTheme.themeData,
      home: const _RootShell(),
    );
  }
}

class _RootShell extends StatelessWidget {
  const _RootShell();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiquidGlassTheme.bgDeep,
      body: AnimatedBackground(
        child: const GalleryScreen(),
      ),
    );
  }
}
