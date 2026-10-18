import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../di.dart';
import '../../controllers/session_controller.dart';

/// Animated splash: brand reveal, then routes by onboarding + session state.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..forward();

  late final Animation<double> _fade =
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(AppConstants.splashDuration, _navigateNext);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _navigateNext() {
    if (!mounted) return;
    final onboarded =
        ref.read(localStorageDataSourceProvider).onboardingCompleted;
    if (!onboarded) {
      context.go(RouteNames.onboarding);
      return;
    }
    final user = ref.read(sessionControllerProvider).value;
    context.go(user != null ? RouteNames.home : RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.crimsonDark, AppColors.crimson],
          ),
        ),
        child: FadeTransition(
          opacity: _fade,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.86, end: 1)
                .animate(CurvedAnimation(parent: _fade, curve: Curves.easeOut)),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _Monogram(),
                  const SizedBox(height: 22),
                  const Text(
                    AppConstants.appName,
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppConstants.appTagline,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.85),
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 46),
                  const SizedBox(
                    width: 26,
                    height: 26,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: AppColors.goldLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Monogram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.goldLight, width: 2),
      ),
      alignment: Alignment.center,
      child: const Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.workspace_premium_rounded,
              size: 44, color: AppColors.goldLight),
        ],
      ),
    );
  }
}
