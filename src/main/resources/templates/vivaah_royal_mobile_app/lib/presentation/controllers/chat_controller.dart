import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di.dart';
import '../../domain/entities/chat.dart';

/// Chat ViewModel: loads conversations, sends messages and reflects the
/// simulated partner reply (with a typing indicator) into UI state.
class ChatController extends AsyncNotifier<ChatData> {
  @override
  Future<ChatData> build() {
    return ref.watch(chatRepositoryProvider).loadAll();
  }

  Future<void> send({
    required String conversationId,
    required String text,
  }) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    final repository = ref.read(chatRepositoryProvider);

    state = AsyncValue.data(
      await repository.sendMessage(
        conversationId: conversationId,
        text: trimmed,
      ),
    );

    ref.read(typingProvider.notifier).show(conversationId);
    final withReply = await repository.waitForIncomingMessage(conversationId);
    if (!ref.mounted) return;
    ref.read(typingProvider.notifier).hide(conversationId);
    state = AsyncValue.data(withReply);
    // Thread is visible while replying; keep the unread badge clean.
    state = AsyncValue.data(await repository.markRead(conversationId));
  }

  Future<void> markRead(String conversationId) async {
    final repository = ref.read(chatRepositoryProvider);
    state = AsyncValue.data(await repository.markRead(conversationId));
  }
}

final chatControllerProvider =
    AsyncNotifierProvider<ChatController, ChatData>(ChatController.new);

/// Messages of a single thread, derived from the aggregate chat snapshot.
final messagesForProvider =
    Provider.family<List<ChatMessage>, String>((ref, conversationId) {
  final data = ref.watch(chatControllerProvider).value;
  return data?.messagesByConversation[conversationId] ??
      const <ChatMessage>[];
});

/// Conversation metadata lookup by id.
final conversationByIdProvider =
    Provider.family<Conversation?, String>((ref, conversationId) {
  final data = ref.watch(chatControllerProvider).value;
  for (final conversation in data?.conversations ?? const <Conversation>[]) {
    if (conversation.id == conversationId) return conversation;
  }
  return null;
});

/// Typing indicator state for simulated partner replies.
class TypingIndicator extends Notifier<Set<String>> {
  @override
  Set<String> build() => const <String>{};

  void show(String conversationId) =>
      state = <String>{...state, conversationId};

  void hide(String conversationId) =>
      state = state.where((id) => id != conversationId).toSet();
}

final typingProvider = NotifierProvider<TypingIndicator, Set<String>>(
  TypingIndicator.new,
);
