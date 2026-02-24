import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';
import '../widgets/liquid_glass_container.dart';
import 'glass_button.dart';

class GlassGalleryModal extends StatelessWidget {
  final Widget imageChild;

  const GlassGalleryModal({super.key, required this.imageChild});

  /// Opens a fullscreen, responsive gallery modal built securely for Web
  /// Prevents InteractiveViewer from blowing up the viewport by constraining it dynamically
  static Future<void> showFullscreen(BuildContext context, {required Widget imageChild}) {
    return showDialog(
      context: context,
      useSafeArea: false,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (ctx) {
        return Dialog.fullscreen(
          backgroundColor: Colors.transparent,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: GlassGalleryModal(imageChild: imageChild),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Secure Web Viewport Strategy: LayoutBuilder + ConstrainedBox
          LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth,
                    maxHeight: constraints.maxHeight,
                  ),
                  child: InteractiveViewer(
                    panEnabled: true,
                    minScale: 1.0,
                    maxScale: 4.0,
                    child: imageChild, // Assume parent passes FittedBox or Image(fit: BoxFit.contain)
                  ),
                ),
              );
            },
          ),
          
          // Close button overlay
          Positioned(
            top: 24,
            right: 24,
            child: GlassButton(
              icon: Icons.close_rounded,
              variant: GlassButtonVariant.icon,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
