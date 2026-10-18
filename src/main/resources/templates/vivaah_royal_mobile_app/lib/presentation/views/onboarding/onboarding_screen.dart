import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../di.dart';

/// First-launch onboarding: three value propositions, then straight to
/// authentication. Completing it is persisted once.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _page = 0;

  static const List<_Slide> _slides = <_Slide>[
    _Slide(
      icon: Icons.favorite_rounded,
      title: 'Find your royal match',
      body:
          'Browse verified profiles curated for shared values, community and '
          'lifestyle — a match made with dignity.',
    ),
    _Slide(
      icon: Icons.verified_user_rounded,
      title: 'Verified & trusted',
      body:
          'Every profile passes document verification. Premium members get an '
          'additional background-verified shortlist.',
    ),
    _Slide(
      icon: Icons.forum_rounded,
      title: 'Chat with confidence',
      body:
          'Express interest, get accepted and start conversations in a private, '
          'respectful space built for families.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    ref.read(localStorageDataSourceProvider).setOnboardingCompleted();
    if (!mounted) return;
    context.go(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLast = _page == _slides.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _finish,
                child: const Text('Skip'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (index) => setState(() => _page = index),
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [AppColors.crimson, AppColors.crimsonDark],
                            ),
                            borderRadius: BorderRadius.circular(44),
                          ),
                          child: Icon(slide.icon, size: 56, color: AppColors.goldLight),
                        ),
                        const SizedBox(height: 36),
                        Text(
                          slide.title,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 14),
                        Text(
                          slide.body,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: index == _page ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: index == _page
                        ? AppColors.crimson
                        : AppColors.outline,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  if (_page > 0)
                    TextButton(
                      onPressed: () => _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      ),
                      child: const Text('Back'),
                    ),
                  const Spacer(),
                  FilledButton(
                    onPressed: isLast
                        ? _finish
                        : () => _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            ),
                    child: Text(isLast ? 'Get Started' : 'Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Slide {
  const _Slide({required this.icon, required this.title, required this.body});

  final IconData icon;
  final String title;
  final String body;
}
