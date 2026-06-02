import 'dart:ui';
import 'package:flutter/material.dart';

/// Real school/classroom photo from Unsplash (free, no API key needed).
/// Splash uses [showBlur: false] for a clean full image.
/// Login & SignUp use [showBlur: true] for frosted glass effect.
class SchoolBackground extends StatelessWidget {
  final Widget child;
  final bool showBlur;

  const SchoolBackground({
    super.key,
    required this.child,
    this.showBlur = true,
  });

  // Free Unsplash photo — bright classroom with students
  static const _imageUrl =
      'https://images.unsplash.com/photo-1580582932707-520aed937b7b'
      '?w=800&q=80&fit=crop';

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // ── Real school photo ──────────────────────────────────
        Image.network(
          _imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (_, child, progress) {
            if (progress == null) return child;
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A3A6B), Color(0xFF2563EB)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            );
          },
          errorBuilder: (_, _, _) => Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A3A6B), Color(0xFF2563EB)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        // ── Blur layer (Login & SignUp only) ───────────────────
        if (showBlur)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: const SizedBox.expand(),
          ),

        // ── Dark blue tint overlay ─────────────────────────────
        Container(
          color: showBlur
              ? const Color(0xFF0D2B6B).withOpacity(0.55)
              : const Color(0xFF0D2B6B).withOpacity(0.30),
        ),

        // ── Actual screen content ──────────────────────────────
        child,
      ],
    );
  }
}
