import '../entities/interest.dart';
import '../entities/profile.dart';

/// Contract for browsing profiles, shortlisting and interests.
abstract interface class ProfileRepository {
  /// All browsable profiles. Offline-first: cached copy is served when the
  /// network layer is unavailable.
  Future<List<Profile>> fetchProfiles();

  /// Fetches a single profile by id, or `null` when unknown.
  Future<Profile?> fetchProfileById(String id);

  // ── Shortlist ────────────────────────────────────────────────────────────
  Set<String> getShortlistIds();
  Future<Set<String>> toggleShortlist(String profileId);
  bool isShortlisted(String profileId);

  // ── Interests ────────────────────────────────────────────────────────────
  Map<String, InterestRecord> getInterests();
  Future<InterestRecord> sendInterest(String profileId);
  bool hasInterest(String profileId);

  /// Demo transport: resolves after a short delay with an `accepted` record,
  /// simulating the member's positive response. A production implementation
  /// would surface the same transition via push notification / websocket.
  Future<InterestRecord> awaitAcceptance(String profileId);
}
