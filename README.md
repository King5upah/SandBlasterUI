# Sandblaster UI 🪟🌊

A premium Flutter Web design system focused on glass-inspired aesthetics. Inspired by "Liquid Glass" design principles (WWDC 2025), Sandblaster brings translucent materials, real-time light refraction, and fluid physics-based animations to your Flutter applications.

![Sandblaster Overview](docs/screenshots/01_overview.png)

## 🚀 Adoption Guide

If you have an existing Flutter app and want to adopt the Sandblaster design language, follow these steps:

### 1. Add Dependencies
Add the following to your `pubspec.yaml`:
```yaml
dependencies:
  google_fonts: ^6.2.1
  flutter_animate: ^4.5.0
```

### 2. Copy the Sandblaster Core
Copy the following directories from this repo into your project:
- `lib/theme/` (Design tokens and themes)
- `lib/widgets/` (Core primitives like `LiquidGlassContainer` and `AnimatedBackground`)
- `lib/components/` (All UI components)

### 3. Initialize the Theme
Wrap your `MaterialApp` with the `LiquidGlassTheme` using the new `SandblasterThemeData` extension profiles:
```dart
import 'package:your_app/theme/liquid_glass_theme.dart';

MaterialApp(
  // Choose between darkTheme, lightTheme, rubyTheme, latteTheme, or inkyTheme
  theme: LiquidGlassTheme.darkTheme, 
  home: YourRootWidget(),
)
```

### 4. Add the Animated Background
For the full effect, wrap your screens in the `AnimatedBackground`:
```dart
import 'package:your_app/widgets/animated_background.dart';

Scaffold(
  body: AnimatedBackground(
    child: YourContent(),
  ),
)
```

### 5. Use Glass Components
Replace standard widgets with Sandblaster components:
```dart
import 'package:your_app/widgets/liquid_glass_container.dart';
import 'package:your_app/components/glass_button.dart';

LiquidGlassContainer(
  child: Column(
    children: [
      Text("Frosted Surface"),
      GlassButton(
        label: "Primary Action",
        onPressed: () {},
      ),
    ],
  ),
)
```

## 📸 Component Showcase

| Overview | Buttons |
|---|---|
| ![Overview](docs/screenshots/01_overview.png) | ![Buttons](docs/screenshots/02_buttons.png) |

| Cards | Inputs |
|---|---|
| ![Cards](docs/screenshots/03_cards.png) | ![Inputs](docs/screenshots/04_screenshots/04_inputs.png) |

| Toggles & Chips | Sliders & Tabs |
|---|---|
| ![Toggles](docs/screenshots/05_toggles.png) | ![Sliders](docs/screenshots/06_sliders.png) |

| Modals & Toasts | Surfaces |
|---|---|
| ![Modals](docs/screenshots/07_modals.png) | ![Surfaces](docs/screenshots/08_surfaces.png) |

## 🛠 Features

- **LiquidGlassContainer**: Frosted glass surfaces with real-time backdrop blur, specular highlights, and mouse-tracking shimmer. Now supports **Toggleable Shadows** (`showShadow: false`).
- **AnimatedBackground**: Smoothly moving gradient orbs using `CustomPainter` for high performance, heavily optimized via `RepaintBoundary` architecture.
- **Physics Motion**: All animations use physics-based curves for a natural, premium feel.
- **Accessibility Integration**: Built-in support for `Semantics` and keyboard-accessible Focus Rings via `FocusableActionDetector`.
- **Flexible Theme Engine**: Support for entirely opaque backgrounds (`useOpaqueBackground`) enabling alternative textures like the new paper-inspired `inkyTheme`.
- **Pre-built Components**: Now includes native-like `GlassAlertDialog` alongside buttons, cards, toggles, text fields, tabs, and more.

### 🛡 Web & Desktop Architecture (v2.0.0)
Sandblaster is hardened for flexible viewport environments:
- **Flex Layout Controls**: `GlassCard` supports `contentMaxWidth` and `contentAlignment` to prevent component stretching on ultrawide displays.
- **GlassGalleryModal**: A safe, fullscreen modal built on `Dialog.fullscreen` and `SafeArea`, dynamically constraining `InteractiveViewer` bounds to prevent Web render crashes.
- **Hit Test Boundaries**: All interactive components expose `hitTestBehavior` to prevent "ghost touches" through overlapping glass layers.
- **Accessible By Default**: Components map tightly to standardized semantics and ARIA-aligned paradigms out of the box.

---
*Built with Flutter Web · 2025*
