import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../controllers/chat_controller.dart';
import '../../controllers/profiles_controller.dart';
import '../../controllers/session_controller.dart';
import '../../widgets/initials_avatar.dart';
import '../shell/app_shell.dart';

/// "My Vivaah" tab: member identity, activity stats and account actions.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(sessionControllerProvider).value;
    final theme = Theme.of(context);

    final shortlistCount = ref.watch(shortlistControllerProvider).length;
    final interestCount = ref.watch(interestsControllerProvider).length;
    final unread = ref.watch(
      chatControllerProvider.select(
        (data) => data.value?.totalUnread ?? 0,
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const BrandTitle()),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  InitialsAvatar(name: user?.fullName ?? 'VR', size: 62),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.fullName ?? 'Royal Member',
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          user?.email ?? '',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.goldContainer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Free member · Upgrade anytime',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.onGoldContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _StatCard(
                icon: Icons.favorite_rounded,
                label: 'Interests sent',
                value: '$interestCount',
              ),
              const SizedBox(width: 12),
              _StatCard(
                icon: Icons.bookmark_rounded,
                label: 'Shortlisted',
                value: '$shortlistCount',
              ),
              const SizedBox(width: 12),
              _StatCard(
                icon: Icons.mark_email_unread_rounded,
                label: 'Unread chats',
                value: '$unread',
              ),
            ],
          ),
          const SizedBox(height: 22),
          _MenuCard(
            children: [
              _MenuTile(
                icon: Icons.workspace_premium_rounded,
                title: 'My membership',
                subtitle: 'Plans, billing and benefits',
                onTap: () => context.push(RouteNames.membership),
              ),
              _MenuTile(
                icon: Icons.search_rounded,
                title: 'Advanced search',
                subtitle: 'Refine by community, profession and more',
                onTap: () => context.go(RouteNames.search),
              ),
              _MenuTile(
                icon: Icons.favorite_border_rounded,
                title: 'My shortlist',
                subtitle: 'Profiles you saved for later',
                onTap: () => context.go(RouteNames.home),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _MenuCard(
            children: [
              _MenuTile(
                icon: Icons.help_outline_rounded,
                title: 'Help & support',
                subtitle: 'FAQs and member care',
                onTap: () => _comingSoon(context, 'Help & support'),
              ),
              _MenuTile(
                icon: Icons.settings_outlined,
                title: 'Settings',
                subtitle: 'Notifications, privacy and preferences',
                onTap: () => _comingSoon(context, 'Settings'),
              ),
              _MenuTile(
                icon: Icons.logout_rounded,
                title: 'Sign out',
                subtitle: 'End this session',
                destructive: true,
                onTap: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: const Text('Sign out?'),
                      content: const Text(
                        'You can sign back in any time with your credentials.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.of(dialogContext).pop(false),
                          child: const Text('Cancel'),
                        ),
                        FilledButton(
                          onPressed: () =>
                              Navigator.of(dialogContext).pop(true),
                          child: const Text('Sign out'),
                        ),
                      ],
                    ),
                  );
                  if (confirmed == true) {
                    await ref.read(sessionControllerProvider.notifier).signOut();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _comingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature ships in the production build')),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Icon(icon, color: AppColors.crimson, size: 22),
              const SizedBox(height: 8),
              Text(
                value,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: children),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.destructive = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = destructive ? theme.colorScheme.error : AppColors.crimson;
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.09),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 20, color: color),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: destructive ? theme.colorScheme.error : null,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.muted),
    );
  }
}
