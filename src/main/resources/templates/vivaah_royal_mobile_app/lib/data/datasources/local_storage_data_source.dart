import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/chat.dart';
import '../../domain/entities/interest.dart';
import '../../domain/entities/user.dart';

/// Thin, typed wrapper around [SharedPreferencesWithCache].
///
/// Only this class knows the persistence keys — repositories deal purely
/// with domain objects, which keeps storage swappable (Hive/Isar later).
class LocalStorageDataSource {
  LocalStorageDataSource(this._prefs);

  final SharedPreferencesWithCache _prefs;

  static const String _keySessionToken = 'vr.session.token';
  static const String _keySessionUser = 'vr.session.user';
  static const String _keyOnboardingDone = 'vr.onboarding.done';
  static const String _keyShortlist = 'vr.shortlist.ids';
  static const String _keyInterests = 'vr.interests.map';
  static const String _keyChatThreads = 'vr.chat.threads';

  // ── Session ──────────────────────────────────────────────────────────────
  String? readSessionToken() => _prefs.getString(_keySessionToken);

  AppUser? readSessionUser() {
    final raw = _prefs.getString(_keySessionUser);
    if (raw == null) return null;
    try {
      return AppUser.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } on Exception {
      return null;
    }
  }

  void writeSession({
    required String token,
    required AppUser user,
  }) {
    _prefs
      ..setString(_keySessionToken, token)
      ..setString(_keySessionUser, jsonEncode(user.toJson()));
  }

  void clearSession() {
    _prefs.remove(_keySessionToken);
    _prefs.remove(_keySessionUser);
  }

  // ── Onboarding ───────────────────────────────────────────────────────────
  bool get onboardingCompleted =>
      _prefs.getBool(_keyOnboardingDone) ?? false;

  void setOnboardingCompleted() => _prefs.setBool(_keyOnboardingDone, true);

  // ── Shortlist ────────────────────────────────────────────────────────────
  Set<String> readShortlist() =>
      (_prefs.getStringList(_keyShortlist) ?? const <String>[]).toSet();

  void writeShortlist(Set<String> ids) =>
      _prefs.setStringList(_keyShortlist, ids.toList());

  // ── Interests ────────────────────────────────────────────────────────────
  Map<String, InterestRecord> readInterests() {
    final raw = _prefs.getString(_keyInterests);
    if (raw == null) return <String, InterestRecord>{};
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map(
      (profileId, value) => MapEntry(
        profileId,
        InterestRecord.fromJson(value as Map<String, dynamic>),
      ),
    );
  }

  void writeInterests(Map<String, InterestRecord> interests) {
    final raw = interests.map(
      (_, record) => MapEntry(record.profileId, record.toJson()),
    );
    _prefs.setString(_keyInterests, jsonEncode(raw));
  }

  // ── Chat threads ─────────────────────────────────────────────────────────
  ChatData? readChatThreads() {
    final raw = _prefs.getString(_keyChatThreads);
    if (raw == null) return null;
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      final conversations = (decoded['conversations'] as List<dynamic>)
          .map((c) => Conversation.fromJson(c as Map<String, dynamic>))
          .toList(growable: false);
      final messagesRaw =
          decoded['messages'] as Map<String, dynamic>;
      final messages = messagesRaw.map(
        (convId, list) => MapEntry(
          convId,
          (list as List<dynamic>)
              .map((m) => ChatMessage.fromJson(m as Map<String, dynamic>))
              .toList(growable: false),
        ),
      );
      return ChatData(
        conversations: conversations,
        messagesByConversation: messages,
      );
    } on Exception {
      return null;
    }
  }

  void writeChatThreads(ChatData data) {
    final raw = <String, dynamic>{
      'conversations': data.conversations.map((c) => c.toJson()).toList(),
      'messages': data.messagesByConversation.map(
        (convId, list) => MapEntry(convId, list.map((m) => m.toJson()).toList()),
      ),
    };
    _prefs.setString(_keyChatThreads, jsonEncode(raw));
  }

  /// Demo helper: forget everything except onboarding.
  void clearMemberData() {
    _prefs
      ..remove(_keyShortlist)
      ..remove(_keyInterests)
      ..remove(_keyChatThreads);
  }

  String newId(String prefix) =>
      '$prefix-${DateTime.now().microsecondsSinceEpoch}';
}
