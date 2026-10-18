import 'dart:async';

import '../../core/constants/app_constants.dart';
import '../../core/errors/app_exceptions.dart';
import '../../data/datasources/local_storage_data_source.dart';
import '../../data/datasources/mock_data_source.dart';
import '../../domain/entities/interest.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';

/// Mock + local-storage implementation of [ProfileRepository].
///
/// Reads are served from [MockDataSource] (offline dataset); member actions
/// (shortlist, interests) persist through [LocalStorageDataSource] so state
/// survives restarts.
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._mock, this._storage);

  final MockDataSource _mock;
  final LocalStorageDataSource _storage;

  @override
  Future<List<Profile>> fetchProfiles() async {
    await Future<void>.delayed(AppConstants.mockNetworkLatency);
    return _mock.profiles;
  }

  @override
  Future<Profile?> fetchProfileById(String id) async {
    final profiles = await fetchProfiles();
    for (final profile in profiles) {
      if (profile.id == id) return profile;
    }
    return null;
  }

  // ── Shortlist ────────────────────────────────────────────────────────────

  @override
  Set<String> getShortlistIds() => _storage.readShortlist();

  @override
  bool isShortlisted(String profileId) =>
      getShortlistIds().contains(profileId);

  @override
  Future<Set<String>> toggleShortlist(String profileId) async {
    final ids = getShortlistIds();
    if (ids.contains(profileId)) {
      ids.remove(profileId);
    } else {
      ids.add(profileId);
    }
    _storage.writeShortlist(ids);
    return ids;
  }

  // ── Interests ────────────────────────────────────────────────────────────

  @override
  Map<String, InterestRecord> getInterests() => _storage.readInterests();

  @override
  bool hasInterest(String profileId) =>
      getInterests().containsKey(profileId);

  @override
  Future<InterestRecord> sendInterest(String profileId) async {
    final interests = getInterests();
    final existing = interests[profileId];
    if (existing != null) {
      throw DomainException('You have already sent an interest to this member');
    }
    final record = InterestRecord(
      profileId: profileId,
      status: InterestStatus.sent,
      sentAt: DateTime.now(),
    );
    interests[profileId] = record;
    _storage.writeInterests(interests);
    return record;
  }

  /// Demo transport: completes after [AppConstants.mockInterestAcceptDelay]
  /// with an `accepted` record (simulating the member responding positively).
  /// In production this would be a push notification / websocket event.
  @override
  Future<InterestRecord> awaitAcceptance(String profileId) async {
    await Future<void>.delayed(AppConstants.mockInterestAcceptDelay);
    final interests = getInterests();
    final record = interests[profileId];
    if (record == null) {
      throw DomainException('No interest found for this member');
    }
    final accepted = record.copyWith(status: InterestStatus.accepted);
    interests[profileId] = accepted;
    _storage.writeInterests(interests);
    return accepted;
  }
}
