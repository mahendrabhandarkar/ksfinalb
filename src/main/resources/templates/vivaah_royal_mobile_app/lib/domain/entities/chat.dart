/// A one-to-one chat thread between the member and a matched profile.
class Conversation {
  const Conversation({
    required this.id,
    required this.profileId,
    required this.lastActivity,
    this.unreadCount = 0,
  });

  /// For 1:1 demo chats the conversation id equals the partner profile id.
  final String id;
  final String profileId;
  final DateTime lastActivity;
  final int unreadCount;

  Conversation copyWith({
    String? id,
    String? profileId,
    DateTime? lastActivity,
    int? unreadCount,
  }) {
    return Conversation(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      lastActivity: lastActivity ?? this.lastActivity,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'profileId': profileId,
        'lastActivity': lastActivity.toIso8601String(),
        'unreadCount': unreadCount,
      };

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        id: json['id'] as String,
        profileId: json['profileId'] as String,
        lastActivity:
            DateTime.tryParse(json['lastActivity'] as String? ?? '') ??
                DateTime.fromMillisecondsSinceEpoch(0),
        unreadCount: json['unreadCount'] as int? ?? 0,
      );

  @override
  bool operator ==(Object other) => other is Conversation && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// A single chat bubble.
class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.conversationId,
    required this.text,
    required this.sentAt,
    required this.fromMe,
  });

  final String id;
  final String conversationId;
  final String text;
  final DateTime sentAt;
  final bool fromMe;

  ChatMessage copyWith({DateTime? sentAt}) => ChatMessage(
        id: id,
        conversationId: conversationId,
        text: text,
        sentAt: sentAt ?? this.sentAt,
        fromMe: fromMe,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'conversationId': conversationId,
        'text': text,
        'sentAt': sentAt.toIso8601String(),
        'fromMe': fromMe,
      };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json['id'] as String,
        conversationId: json['conversationId'] as String,
        text: json['text'] as String,
        sentAt: DateTime.tryParse(json['sentAt'] as String? ?? '') ??
            DateTime.fromMillisecondsSinceEpoch(0),
        fromMe: json['fromMe'] as bool? ?? false,
      );

  @override
  bool operator ==(Object other) => other is ChatMessage && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Aggregate snapshot loaded once and kept in memory by the chat controller.
class ChatData {
  const ChatData({
    required this.conversations,
    required this.messagesByConversation,
  });

  final List<Conversation> conversations;
  final Map<String, List<ChatMessage>> messagesByConversation;

  int get totalUnread => conversations.fold(
        0,
        (sum, c) => sum + c.unreadCount,
      );

  ChatData copyWith({
    List<Conversation>? conversations,
    Map<String, List<ChatMessage>>? messagesByConversation,
  }) {
    return ChatData(
      conversations: conversations ?? this.conversations,
      messagesByConversation:
          messagesByConversation ?? this.messagesByConversation,
    );
  }
}
