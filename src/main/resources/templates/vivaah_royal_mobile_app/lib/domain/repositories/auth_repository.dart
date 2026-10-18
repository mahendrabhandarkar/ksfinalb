import '../entities/user.dart';

/// Contract for authentication use-cases.
///
/// The presentation layer depends only on this interface; swapping the mock
/// implementation for a real backend (Firebase Auth / REST) requires no
/// changes anywhere else.
abstract interface class AuthRepository {
  /// Restores a persisted session at app start. Returns `null` when the
  /// member is signed out.
  Future<AppUser?> restoreSession();

  /// Signs in with email/mobile + password and returns the member.
  Future<AppUser> signInWithPassword({
    required String identifier,
    required String password,
  });

  /// Sends an OTP to [phone]. Returns the generated code in the demo build
  /// (a production implementation would dispatch it via SMS gateway).
  Future<String> requestOtp({required String phone});

  /// Verifies [code] against the OTP issued for [phone].
  Future<AppUser> verifyOtp({required String phone, required String code});

  /// Creates a new member account from [data] and signs in.
  Future<AppUser> register(RegisterFormData data);

  /// Clears the persisted session.
  Future<void> signOut();
}
