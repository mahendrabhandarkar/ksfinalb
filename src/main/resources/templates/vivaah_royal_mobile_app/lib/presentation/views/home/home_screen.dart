import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../controllers/profiles_controller.dart';
import '../../controllers/session_controller.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/profile_card.dart';
import '../../widgets/section_header.dart';
import '../shell/app_shell.dart';

/// Home feed: greeting, search entry, premium carousel and recommendations.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = ref.watch(recommendedProfilesProvider);
    final premium = ref.watch(premiumProfilesProvider);
    final user = ref.watch(sessionControllerProvider).value;
    final asyncProfiles = ref.watch(profilesControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const BrandTitle(),
        actions: [
          IconButton(
            tooltip: 'Membership plans',
            onPressed: () => context.push(RouteNames.membership),
            icon: const Icon(Icons.workspace_premium_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: asyncProfiles.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => EmptyState(
          icon: Icons.cloud_off_rounded,
          title: 'Could not load matches',
          message: '$error',
          actionLabel: 'Retry',
          onAction: () =>
              ref.read(profilesControllerProvider.notifier).refresh(),
        ),
        data: (_) => RefreshIndicator(
          color: AppColors.crimson,
          onRefresh: () =>
              ref.read(profilesControllerProvider.notifier).refresh(),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            children: [
              _Greeting(name: user?.firstName ?? 'Royal Member'),
              const SizedBox(height: 16),
              _SearchEntry(theme: theme),
              const SizedBox(height: 24),
              if (premium.isNotEmpty) ...[
                SectionHeader(
                  title: 'Premium matches',
                  actionLabel: 'View plans',
                  onAction: () => context.push(RouteNames.membership),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    itemCount: premium.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
                    itemBuilder: (context, index) => SizedBox(
                      width: 200,
                      child: ProfileCard(
                        profile: premium[index],
                        onTap: () => context.push(
                          RouteNames.profileFor(premium[index].id),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 26),
              ],
              SectionHeader(title: 'New matches for you'),
              if (profiles.isEmpty)
                EmptyState(
                  icon: Icons.favorite_border_rounded,
                  title: 'No matches yet',
                  message:
                      'Widen your search filters or check back soon — new '
                      'members join every day.',
                  actionLabel: 'Open search',
                  onAction: () => context.go(RouteNames.search),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: profiles.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    mainAxisExtent: 300,
                  ),
                  itemBuilder: (context, index) => ProfileCard(
                    profile: profiles[index],
                    onTap: () => context.push(
                      RouteNames.profileFor(profiles[index].id),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Namaste, $name',
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 4),
        Text(
          'Your royal matches await — refreshed just now.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _SearchEntry extends StatelessWidget {
  const _SearchEntry({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => context.go(RouteNames.search),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.outline),
        ),
        child: Row(
          children: [
            const Icon(Icons.search_rounded, color: AppColors.muted),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Search by name, city, profession…',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: AppColors.goldContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.tune_rounded,
                  size: 18, color: AppColors.onGoldContainer),
            ),
          ],
        ),
      ),
    );
  }
}
