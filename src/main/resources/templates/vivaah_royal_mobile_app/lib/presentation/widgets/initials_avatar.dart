import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Elegant fallback avatar: initials on a deterministic brand gradient.
///
/// Used whenever a profile photo is missing or fails to load, so the UI
/// always looks intentional.
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({
    required this.name,
    this.size = 56,
    this.borderRadius,
    super.key,
  });

  final String name;
  final double size;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final gradient = AppColors.avatarGradients[
        name.hashCode.abs() % AppColors.avatarGradients.length];
    final initials = _initialsOf(name);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(size * 0.32),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: size * 0.36,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  static String _initialsOf(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList(growable: false);
    if (parts.isEmpty) return '?';
    final first = parts.first[0];
    final last = parts.length > 1 ? parts.last[0] : '';
    return (first + last).toUpperCase();
  }
}
