import '../../core/constants/app_constants.dart';
import '../../data/datasources/local_storage_data_source.dart';
import '../../data/datasources/mock_data_source.dart';
import '../../domain/entities/chat.dart';
import '../../domain/repositories/chat_repository.dart';

/// Mock + local-storage implementation of [ChatRepository].
///
/// Threads are seeded from [MockDataSource] on first launch, persisted via
/// [LocalStorageDataSource], and partner replies are simulated by the demo
/// transport. In production the same contract would be implemented with a
/// WebSocket / Firebase stream.
class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._mock, this._storage);

  final MockDataSource _mock;
  final LocalStorageDataSource _storage;

  ChatData? _cache;
  final Map<String, int> _replyCounter = <String, int>{};

  @override
  Future<ChatData> loadAll() async {
    final stored = _storage.readChatThreads();
    if (stored != null) {
      _cache = stored;
      return stored;
    }
    final seeded = _mock.seedChatData();
    _storage.writeChatThreads(seeded);
    _cache = seeded;
    return seeded;
  }

  @override
  Future<ChatData> markRead(String conversationId) async {
    final data = _require();
    final updatedConversations = data.conversations
        .map(
          (c) =>
              c.id == conversationId ? c.copyWith(unreadCount: 0) : c,
        )
        .toList(growable: false);
    final updated = data.copyWith(conversations: updatedConversations);
    _commit(updated);
    return updated;
  }

  @override
  Future<ChatData> sendMessage({
    required String conversationId,
    required String text,
  }) async {
    final data = _require();
    final message = ChatMessage(
      id: _storage.newId('m'),
      conversationId: conversationId,
      text: text.trim(),
      sentAt: DateTime.now(),
      fromMe: true,
    );
    final updated = _withMessage(data, message);
    _commit(updated);
    return updated;
  }

  /// Demo transport: resolves after [AppConstants.mockReplyDelay] with the
  /// partner's simulated reply appended and persisted.
  @override
  Future<ChatData> waitForIncomingMessage(String conversationId) async {
    await Future<void>.delayed(AppConstants.mockReplyDelay);
    final data = _require();
    final count = (_replyCounter[conversationId] ?? 0) + 1;
    _replyCounter[conversationId] = count;
    final reply = ChatMessage(
      id: _storage.newId('m'),
      conversationId: conversationId,
      text: _mock.cannedReply(conversationId, count),
      sentAt: DateTime.now(),
      fromMe: false,
    );
    final withReply = _withMessage(data, reply);
    final conversations = withReply.conversations
        .map(
          (c) => c.id == conversationId
              ? c.copyWith(
                  unreadCount: c.unreadCount + 1,
                  lastActivity: reply.sentAt,
                )
              : c,
        )
        .toList(growable: false);
    final updated = withReply.copyWith(conversations: conversations);
    _commit(updated);
    return updated;
  }

  // ── Internals ────────────────────────────────────────────────────────────

  ChatData _require() => _cache ?? _mock.seedChatData();

  ChatData _withMessage(ChatData data, ChatMessage message) {
    final messages = Map<String, List<ChatMessage>>.of(
      data.messagesByConversation,
    );
    final thread = <ChatMessage>[
      ...(messages[message.conversationId] ?? const <ChatMessage>[]),
      message,
    ];
    messages[message.conversationId] = thread;

    final exists =
        data.conversations.any((c) => c.id == message.conversationId);
    final conversations = exists
        ? data.conversations
            .map(
              (c) => c.id == message.conversationId
                  ? c.copyWith(lastActivity: message.sentAt)
                  : c,
            )
            .toList(growable: false)
        : <Conversation>[
            Conversation(
              id: message.conversationId,
              profileId: message.conversationId,
              lastActivity: message.sentAt,
            ),
            ...data.conversations,
          ];
    return data.copyWith(
      conversations: conversations,
      messagesByConversation: messages,
    );
  }

  void _commit(ChatData data) {
    _cache = data;
    _storage.writeChatThreads(data);
  }
}
