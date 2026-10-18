import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';

/// Bottom-navigation shell hosting the four main tabs via
/// `StatefulShellRoute.indexedStack`, preserving each branch's state.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        height: 68,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            selectedIcon: Icon(Icons.person_search_rounded),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            selectedIcon: Icon(Icons.chat_bubble_rounded),
            label: 'Inbox',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'My Vivaah',
          ),
        ],
      ),
    );
  }
}

/// Shared branded AppBar title used by the tab screens.
class BrandTitle extends StatelessWidget {
  const BrandTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.workspace_premium_rounded,
            color: AppColors.gold, size: 24),
        const SizedBox(width: 8),
        Text(
          AppConstants.appName,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ],
    );
  }
}
