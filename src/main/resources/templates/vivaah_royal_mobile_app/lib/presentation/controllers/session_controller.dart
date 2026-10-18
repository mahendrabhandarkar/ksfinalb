import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di.dart';
import '../../domain/entities/user.dart';

/// Session ViewModel: exposes the signed-in [AppUser] as an `AsyncValue`.
///
/// - `isLoading`      → session being restored at cold start (splash gate).
/// - `value == null`  → signed out.
/// - `value != null`  → signed in (the router redirects accordingly).
///
/// Auth methods deliberately do NOT flip the global state to loading so the
/// router's redirect logic stays stable while a login form is submitting —
/// the submitting state is owned by the form itself.
class SessionController extends AsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() async {
    final repository = ref.watch(authRepositoryProvider);
    return repository.restoreSession();
  }

  Future<void> signInWithPassword({
    required String identifier,
    required String password,
  }) async {
    final repository = ref.read(authRepositoryProvider);
    state = AsyncValue.data(
      await repository.signInWithPassword(
        identifier: identifier,
        password: password,
      ),
    );
  }

  /// Sends an OTP to [phone] and returns the generated code. In the demo
  /// build the code is surfaced to the UI for reviewers; a production
  /// implementation would deliver it via SMS and never echo it back.
  Future<String> requestOtp({required String phone}) {
    final repository = ref.read(authRepositoryProvider);
    return repository.requestOtp(phone: phone);
  }

  Future<void> verifyOtp({required String phone, required String code}) async {
    final repository = ref.read(authRepositoryProvider);
    state = AsyncValue.data(
      await repository.verifyOtp(phone: phone, code: code),
    );
  }

  Future<void> register(RegisterFormData data) async {
    final repository = ref.read(authRepositoryProvider);
    state = AsyncValue.data(await repository.register(data));
  }

  Future<void> signOut() async {
    final repository = ref.read(authRepositoryProvider);
    await repository.signOut();
    state = const AsyncValue.data(null);
  }
}

final sessionControllerProvider =
    AsyncNotifierProvider<SessionController, AppUser?>(
  SessionController.new,
);
