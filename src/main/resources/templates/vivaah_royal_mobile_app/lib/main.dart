import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'di.dart';

/// Composition entry point.
///
/// The preferences cache is created before the widget tree mounts and
/// injected into [ProviderScope] so no widget or controller ever touches a
/// platform channel directly.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(),
  );

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const VivaahRoyalApp(),
    ),
  );
}
