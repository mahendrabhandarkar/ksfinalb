import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di.dart';
import '../../domain/entities/interest.dart';
import '../../domain/entities/profile.dart';
import 'session_controller.dart';

/// Profiles ViewModel: the browsable catalogue plus member actions
/// (shortlist, interests) and derived selections used by the UI.

/// Full catalogue of browsable profiles.
class ProfilesController extends AsyncNotifier<List<Profile>> {
  @override
  Future<List<Profile>> build() {
    return ref.watch(profileRepositoryProvider).fetchProfiles();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

final profilesControllerProvider =
    AsyncNotifierProvider<ProfilesController, List<Profile>>(
  ProfilesController.new,
);

/// Ids shortlisted by the member. Kept separate so cards watch a tiny
/// `Set<String>` instead of rebuilding on catalogue changes.
class ShortlistController extends Notifier<Set<String>> {
  @override
  Set<String> build() {
    return ref.watch(profileRepositoryProvider).getShortlistIds();
  }

  Future<void> toggle(String profileId) async {
    final repository = ref.read(profileRepositoryProvider);
    state = await repository.toggleShortlist(profileId);
  }
}

final shortlistControllerProvider =
    NotifierProvider<ShortlistController, Set<String>>(
  ShortlistController.new,
);

/// Interests keyed by profile id. After sending, the demo transport resolves
/// the acceptance shortly after; the controller awaits it and reflects the
/// `accepted` status so the UI can celebrate the match.
class InterestsController extends Notifier<Map<String, InterestRecord>> {
  @override
  Map<String, InterestRecord> build() {
    return ref.watch(profileRepositoryProvider).getInterests();
  }

  Future<void> send(String profileId) async {
    final repository = ref.read(profileRepositoryProvider);
    final sent = await repository.sendInterest(profileId);
    state = <String, InterestRecord>{...state, profileId: sent};
    final accepted = await repository.awaitAcceptance(profileId);
    if (!ref.mounted) return;
    state = <String, InterestRecord>{...state, profileId: accepted};
  }
}

final interestsControllerProvider =
    NotifierProvider<InterestsController, Map<String, InterestRecord>>(
  InterestsController.new,
);

// ── Derived selections (pure, synchronous) ──────────────────────────────────

/// Opposite-gender recommendations — the matrimony convention.
final recommendedProfilesProvider = Provider<List<Profile>>((ref) {
  final profiles =
      ref.watch(profilesControllerProvider).value ?? const <Profile>[];
  final user = ref.watch(sessionControllerProvider).value;
  final Gender? target = switch (user?.gender) {
    Gender.male => Gender.female,
    Gender.female => Gender.male,
    null => null,
  };
  if (target == null) return profiles;
  return profiles.where((p) => p.gender == target).toList(growable: false);
});

/// Premium subset for the home carousel.
final premiumProfilesProvider = Provider<List<Profile>>((ref) {
  return ref
      .watch(recommendedProfilesProvider)
      .where((p) => p.isPremium)
      .toList(growable: false);
});

/// Lookup by id for the profile detail screen.
final profileByIdProvider = Provider.family<Profile?, String>((ref, id) {
  final profiles =
      ref.watch(profilesControllerProvider).value ?? const <Profile>[];
  for (final profile in profiles) {
    if (profile.id == id) return profile;
  }
  return null;
});
