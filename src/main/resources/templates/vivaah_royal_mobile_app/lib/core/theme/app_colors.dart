import 'package:flutter/material.dart';

/// Brand palette extracted from the Kartavirya Sahasrarjun painting.
///
/// The artwork's deep crimson robes, royal gold ornaments and ivory
/// background define the visual identity of Vivaah Royal.
abstract final class AppColors {
  // ── Core brand ────────────────────────────────────────────────────────────
  static const Color crimson = Color(0xFF8F1D22);
  static const Color crimsonDark = Color(0xFF661114);
  static const Color crimsonContainer = Color(0xFFF9DCDA);
  static const Color onCrimsonContainer = Color(0xFF3F0D10);

  static const Color gold = Color(0xFFC89B2C);
  static const Color goldLight = Color(0xFFE9C46A);
  static const Color goldContainer = Color(0xFFF6EAD0);
  static const Color onGoldContainer = Color(0xFF4A3A08);

  static const Color royalBlue = Color(0xFF2B4C8C);
  static const Color royalBlueContainer = Color(0xFFDCE4F7);

  // ── Neutrals ──────────────────────────────────────────────────────────────
  static const Color ivory = Color(0xFFFAF5EC);
  static const Color surface = Color(0xFFFFFDF8);
  static const Color ink = Color(0xFF33251F);
  static const Color muted = Color(0xFF7A6A5F);
  static const Color outline = Color(0xFFE2D6C3);
  static const Color success = Color(0xFF2E6B3E);

  /// Deterministic gradient pairs used by [InitialsAvatar]-style artwork so
  /// every profile gets a stable, distinctive backdrop.
  static const List<List<Color>> avatarGradients = <List<Color>>[
    <Color>[Color(0xFF8F1D22), Color(0xFFC0392B)],
    <Color>[Color(0xFFB07D1A), Color(0xFFE9C46A)],
    <Color>[Color(0xFF2B4C8C), Color(0xFF4F79C4)],
    <Color>[Color(0xFF1F6B52), Color(0xFF3D9970)],
    <Color>[Color(0xFF6A2C70), Color(0xFF9B59B6)],
    <Color>[Color(0xFF7A3E1D), Color(0xFFC96F32)],
  ];
}
