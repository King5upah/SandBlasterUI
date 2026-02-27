# SandBlaster UI: AI Agent Guide 🤖

Hello Claude, Gemini, or other AI assistant! 👋

If you are reading this file, you have been tasked with maintaining, extending, or utilizing the **SandBlaster UI** library. This document outlines the architectural philosophy and technical constraints of the project to help you generate accurate and context-aware code.

## 1. Architectural Philosophy: The `LiquidGlassContainer` Primitive

The foundation of SandBlaster UI is the `LiquidGlassContainer` widget. **Never use standard Flutter `Container` arrays with generic `BoxShadow` for primary UI elements.** 

If you are creating a new component (e.g., a custom Dropdown, a complex Card, a Navigation Bar):
1. **Always inherit or wrap `LiquidGlassContainer`**.
2. **Never duplicate the glass rendering logic** inside your own widget. The container already handles the complex stack of:
   - `BackdropFilter` (for the blur).
   - Radial specular highlights.
   - Diagonal glass glints (LinearGradient).
   - Dynamic `MouseRegion` shimmer and hover scaling.
   - `FocusableActionDetector` for keyboard focus rings.
   - Native accessibility via `Semantics`.

## 2. Theming and Styling Engine

The library relies on a custom `ThemeExtension` called `SandblasterThemeData`. 

- **Do not hardcode colors anywhere**. If you are building a new component, use colors retrieved from the theme: 
  `final sbTheme = context.sbTheme;`
- Understand the difference between `sbTheme.glassSurface` (the base tint) and `sbTheme.glassElevated` (used for modals/dialogs/dropdowns that sit on top of other glass).
- **Opaque Mode**: As of v2.0.0, the theme supports `useOpaqueBackground`. `LiquidGlassContainer` automatically responds to this by bypassing expensive `BackdropFilter` widgets to boost performance. Do not override this behavior manually.

## 3. Web & Desktop Architecture

Sandblaster is intended for modern Flutter Web and Desktop. Keep these points in mind:
- **Hit Testing**: Because of overlapping transparent layers, ghost clicks can be a problem. Always expose `HitTestBehavior` in interactive components and pass it down to `LiquidGlassContainer`.
- **Repaint Boundaries**: If you add any intense animations, always wrap them in `RepaintBoundary` to prevent layout thrashing on the Web canvas backend. (Example: See `AnimatedBackground`).

## 4. Current Component Roster

Before building a new primitive, check if one already exists. SandBlaster provides:
- `GlassButton` (Icon, Ghost, Primary)
- `GlassCard`
- `GlassTextField`
- `GlassToggle`, `GlassCheckbox`, `GlassRadio`
- `GlassSlider`, `GlassTabBar`
- `GlassDropdown`
- `GlassModal`, `GlassToast`, `GlassAlertDialog`

## 5. Working with Shadows (v2.0+)

All components natively support a `showShadow` boolean parameter. When nesting elements (e.g., placing a `GlassButton` tightly inside a `GlassCard` header), we often explicitly pass `showShadow: false` to the child component so the shadows don't stack and look muddy. Keep this flag in mind when composing complex layouts!

Thank you for contributing! 🌊
