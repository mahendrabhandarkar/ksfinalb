import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/chat.dart';
import '../../controllers/chat_controller.dart';
import '../../controllers/profiles_controller.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/initials_avatar.dart';

/// Conversation list with unread badges and relative timestamps.
class InboxScreen extends ConsumerWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatData = ref.watch(chatControllerProvider);
    final theme = Theme.of(context);

    final conversations = chatData.value?.conversations ?? const <Conversation>[];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          chatData.isLoading ? 'Inbox' : 'Inbox',
          style: theme.appBarTheme.titleTextStyle,
        ),
      ),
      body: chatData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => EmptyState(
          icon: Icons.cloud_off_rounded,
          title: 'Could not load conversations',
          message: '$error',
          actionLabel: 'Retry',
          onAction: () => ref.invalidate(chatControllerProvider),
        ),
        data: (_) => conversations.isEmpty
            ? const EmptyState(
                icon: Icons.forum_outlined,
                title: 'No conversations yet',
                message:
                    'Send an interest to a profile — once it is accepted your '
                    'chat appears here.',
                actionLabel: 'Browse matches',
              )
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                itemCount: conversations.length,
                separatorBuilder: (_, _) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  final conversation = conversations[index];
                  return _ConversationTile(
                    conversation: conversation,
                    onTap: () => context
                        .push(RouteNames.chatFor(conversation.id)),
                  );
                },
              ),
      ),
    );
  }
}

class _ConversationTile extends ConsumerWidget {
  const _ConversationTile({required this.conversation, required this.onTap});

  final Conversation conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final profile = ref.watch(profileByIdProvider(conversation.profileId));
    final messages = ref.watch(messagesForProvider(conversation.id));
    final last = messages.isEmpty ? null : messages.last;
    final name = profile?.fullName ?? 'Vivaah Member';

    return Card(
      child: ListTile(
        onTap: onTap,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        leading: (profile == null || profile.photoUrl == null)
            ? InitialsAvatar(name: profile?.fullName ?? 'VR', size: 52)
            : ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: profile.photoUrl!,
                  width: 52,
                  height: 52,
                  fit: BoxFit.cover,
                  errorWidget: (_, _, _) =>
                      InitialsAvatar(name: profile.fullName, size: 52),
                  placeholder: (_, _) => Container(
                    width: 52,
                    height: 52,
                    color: AppColors.goldContainer,
                  ),
                ),
              ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            if (last != null)
              Text(
                DateFormat('d MMM, h:mm a').format(last.sentAt),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            last?.text ?? 'Say namaste to begin the conversation',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall,
          ),
        ),
        trailing: conversation.unreadCount > 0
            ? Badge(
                label: Text('${conversation.unreadCount}'),
                backgroundColor: AppColors.crimson,
                largeSize: 20,
              )
            : const Icon(Icons.chevron_right_rounded, color: AppColors.muted),
      ),
    );
  }
}
