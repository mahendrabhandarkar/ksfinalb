import '../entities/chat.dart';

/// Contract for chat conversations and messages.
abstract interface class ChatRepository {
  /// Loads every conversation plus its messages (demo scale: in-memory +
  /// persisted cache).
  Future<ChatData> loadAll();

  /// Marks [conversationId] as read.
  Future<ChatData> markRead(String conversationId);

  /// Sends [text] in the thread and returns the updated snapshot.
  Future<ChatData> sendMessage({
    required String conversationId,
    required String text,
  });

  /// Resolves with the next incoming message merged into the snapshot.
  /// The mock transport schedules a simulated partner reply; a production
  /// implementation would await the next WebSocket / FCM event.
  Future<ChatData> waitForIncomingMessage(String conversationId);
}
