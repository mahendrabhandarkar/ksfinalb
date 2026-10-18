import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../domain/entities/profile.dart';
import '../controllers/profiles_controller.dart';
import 'initials_avatar.dart';

/// Large grid card used on the Home feed.
class ProfileCard extends ConsumerWidget {
  const ProfileCard({required this.profile, this.onTap, super.key});

  final Profile profile;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shortlisted = ref.watch(
      shortlistControllerProvider.select(
        (ids) => ids.contains(profile.id),
      ),
    );
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _PhotoOrAvatar(profile: profile),
                  if (profile.isPremium)
                    const Positioned(
                      top: 10,
                      left: 10,
                      child: _PremiumBadge(),
                    ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: _ShortlistButton(
                      shortlisted: shortlisted,
                      profileId: profile.id,
                    ),
                  ),
                  if (profile.isVerified)
                    const Positioned(
                      bottom: 10,
                      left: 10,
                      child: _VerifiedPill(),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${profile.fullName.split(' ').first}, ${profile.age}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          profile.city,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    profile.profession,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
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

/// Compact list row used on Search results.
class ProfileTile extends ConsumerWidget {
  const ProfileTile({required this.profile, this.onTap, super.key});

  final Profile profile;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(12),
        leading: SizedBox(
          width: 56,
          height: 56,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: _PhotoOrAvatar(profile: profile, compact: true),
          ),
        ),
        title: Row(
          children: [
            Flexible(
              child: Text(
                '${profile.fullName.split(' ').first}, ${profile.age}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            if (profile.isVerified) ...[
              const SizedBox(width: 4),
              Icon(Icons.verified_rounded,
                  size: 16, color: theme.colorScheme.tertiary),
            ],
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(
              profile.headline,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              '${profile.city} · ${profile.religion} · ${profile.motherTongue}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: _ShortlistButton(
          shortlisted: ref.watch(
            shortlistControllerProvider.select(
              (ids) => ids.contains(profile.id),
            ),
          ),
          profileId: profile.id,
        ),
      ),
    );
  }
}

// ── Internals ────────────────────────────────────────────────────────────────

class _PhotoOrAvatar extends StatelessWidget {
  const _PhotoOrAvatar({required this.profile, this.compact = false});

  final Profile profile;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final url = profile.photoUrl;
    if (url == null) {
      return InitialsAvatar(
        name: profile.fullName,
        size: compact ? 56 : 220,
        borderRadius: BorderRadius.zero,
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      fadeInDuration: const Duration(milliseconds: 250),
      placeholder: (_, _) => Container(
        color: AppColors.goldContainer,
        alignment: Alignment.center,
        child: const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      errorWidget: (_, _, _) => InitialsAvatar(
        name: profile.fullName,
        size: compact ? 56 : 220,
        borderRadius: BorderRadius.zero,
      ),
    );
  }
}

class _PremiumBadge extends StatelessWidget {
  const _PremiumBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.gold, AppColors.goldLight],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.workspace_premium_rounded, size: 13, color: Colors.white),
          SizedBox(width: 3),
          Text(
            'Premium',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerifiedPill extends StatelessWidget {
  const _VerifiedPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3.5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified_rounded, size: 12, color: AppColors.goldLight),
          SizedBox(width: 3),
          Text(
            'Verified',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShortlistButton extends ConsumerWidget {
  const _ShortlistButton({
    required this.shortlisted,
    required this.profileId,
  });

  final bool shortlisted;
  final String profileId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton.filledTonal(
      tooltip: shortlisted ? 'Remove from shortlist' : 'Add to shortlist',
      onPressed: () =>
          ref.read(shortlistControllerProvider.notifier).toggle(profileId),
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.92),
        foregroundColor: shortlisted ? AppColors.crimson : AppColors.muted,
        minimumSize: const Size(38, 38),
        maximumSize: const Size(38, 38),
      ),
      icon: Icon(
        shortlisted ? Icons.favorite_rounded : Icons.favorite_border_rounded,
        size: 20,
      ),
    );
  }
}
