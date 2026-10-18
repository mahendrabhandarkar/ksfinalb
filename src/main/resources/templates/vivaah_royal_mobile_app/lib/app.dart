import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/app_constants.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

/// Root widget: wires the themed [MaterialApp] to the Riverpod-driven
/// go_router configuration.
class VivaahRoyalApp extends ConsumerWidget {
  const VivaahRoyalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: router,
    );
  }
}
