import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/interest.dart';
import '../../../domain/entities/profile.dart';
import '../../controllers/profiles_controller.dart';
import '../../widgets/initials_avatar.dart';
import '../../widgets/primary_button.dart';

/// Full-screen profile detail: photos, key details and the three member
/// actions — send interest, shortlist, chat.
class ProfileDetailScreen extends ConsumerWidget {
  const ProfileDetailScreen({required this.profileId, super.key});

  final String profileId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileByIdProvider(profileId));
    final theme = Theme.of(context);

    if (profile == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('Profile not found'),
        ),
      );
    }

    final interest = ref.watch(
      interestsControllerProvider.select((map) => map[profile.id]),
    );
    final shortlisted = ref.watch(
      shortlistControllerProvider.select((ids) => ids.contains(profile.id)),
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 380,
            pinned: true,
            backgroundColor: AppColors.crimsonDark,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  _HeroPhoto(profile: profile),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [Colors.black54, Colors.transparent],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -22),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 30),
                decoration: const BoxDecoration(
                  color: AppColors.ivory,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${profile.fullName}, ${profile.age}',
                                      style: theme.textTheme.headlineSmall,
                                    ),
                                  ),
                                  if (profile.isVerified) ...[
                                    const SizedBox(width: 6),
                                    const Icon(Icons.verified_rounded,
                                        size: 20, color: AppColors.royalBlue),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${profile.locationLabel} · ${profile.heightCm} cm',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (profile.isPremium) const _PremiumChip(),
                      ],
                    ),
                    const SizedBox(height: 18),
                    _ActionRow(
                      profileId: profile.id,
                      interest: interest,
                      shortlisted: shortlisted,
                    ),
                    const SizedBox(height: 24),
                    _DetailSection(
                      title: 'About',
                      body: profile.about,
                    ),
                    _DetailGrid(profile: profile),
                    _DetailSection(
                      title: 'Hobbies & interests',
                      bodyWidget: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: profile.hobbies
                            .map(
                              (hobby) => Chip(
                                label: Text(hobby),
                                labelStyle: const TextStyle(fontSize: 12.5),
                                visualDensity: VisualDensity.compact,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends ConsumerWidget {
  const _ActionRow({
    required this.profileId,
    required this.interest,
    required this.shortlisted,
  });

  final String profileId;
  final InterestRecord? interest;
  final bool shortlisted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accepted = interest?.status == InterestStatus.accepted;
    final sent = interest != null;

    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            label: accepted
                ? 'Matched — Say hello'
                : sent
                    ? 'Interest sent'
                    : 'Send Interest',
            icon: accepted
                ? Icons.celebration_rounded
                : Icons.favorite_rounded,
            onPressed: sent
                ? (accepted
                    ? () => context.push(RouteNames.chatFor(profileId))
                    : null)
                : () =>
                    ref.read(interestsControllerProvider.notifier).send(profileId),
          ),
        ),
        const SizedBox(width: 12),
        _CircleAction(
          icon: shortlisted
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          color: shortlisted ? AppColors.crimson : AppColors.muted,
          tooltip: shortlisted ? 'Remove from shortlist' : 'Add to shortlist',
          onPressed: () =>
              ref.read(shortlistControllerProvider.notifier).toggle(profileId),
        ),
        const SizedBox(width: 10),
        _CircleAction(
          icon: Icons.chat_bubble_outline_rounded,
          color: AppColors.royalBlue,
          tooltip: 'Open chat',
          onPressed: accepted
              ? () => context.push(RouteNames.chatFor(profileId))
              : () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Chats open once your interest is accepted'),
                    ),
                  ),
        ),
      ],
    );
  }
}

class _CircleAction extends StatelessWidget {
  const _CircleAction({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: IconButton.outlined(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color.withValues(alpha: 0.45)),
          minimumSize: const Size(52, 52),
        ),
        icon: Icon(icon, size: 22),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({
    required this.title,
    this.body,
    this.bodyWidget,
  });

  final String title;
  final String? body;
  final Widget? bodyWidget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Widget content;
    if (bodyWidget != null) {
      content = bodyWidget!;
    } else if (body != null && body!.isNotEmpty) {
      content = Text(
        body!,
        style: theme.textTheme.bodyMedium?.copyWith(height: 1.55),
      );
    } else {
      content = Text(
        '—',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleLarge),
          const SizedBox(height: 10),
          content,
        ],
      ),
    );
  }
}

class _DetailGrid extends StatelessWidget {
  const _DetailGrid({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entries = <(String, String)>[
      ('Education', profile.education),
      ('Profession', profile.profession),
      ('Annual income', '₹${profile.annualIncomeLakh} Lakh'),
      ('Marital status', profile.maritalStatus.label),
      ('Religion', '${profile.religion} · ${profile.community}'),
      ('Mother tongue', profile.motherTongue),
      ('Diet', profile.diet.label),
      ('Location', profile.locationLabel),
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Basics', style: theme.textTheme.titleLarge),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Column(
                children: [
                  for (var i = 0; i < entries.length; i++) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              entries[i].$1,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              entries[i].$2,
                              textAlign: TextAlign.right,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (i != entries.length - 1)
                      const Divider(height: 1),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PremiumChip extends StatelessWidget {
  const _PremiumChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.gold, AppColors.goldLight],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.workspace_premium_rounded, size: 14, color: Colors.white),
          SizedBox(width: 4),
          Text(
            'Premium',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroPhoto extends StatelessWidget {
  const _HeroPhoto({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final url = profile.photoUrl;
    if (url == null) {
      return InitialsAvatar(
        name: profile.fullName,
        size: double.infinity,
        borderRadius: BorderRadius.zero,
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      errorWidget: (_, _, _) => InitialsAvatar(
        name: profile.fullName,
        size: double.infinity,
        borderRadius: BorderRadius.zero,
      ),
      placeholder: (_, _) => const ColoredBox(
        color: AppColors.crimsonDark,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.goldLight),
        ),
      ),
    );
  }
}
