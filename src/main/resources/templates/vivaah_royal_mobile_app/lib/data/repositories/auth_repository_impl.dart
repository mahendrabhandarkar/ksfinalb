import 'dart:math';

import '../../core/errors/app_exceptions.dart';
import '../../data/datasources/local_storage_data_source.dart';
import '../../data/datasources/remote_auth_data_source.dart';
import '../../domain/entities/profile.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

/// Mock-backed implementation of [AuthRepository].
///
/// Demo behaviour: any well-formed credentials sign in, which makes the app
/// explorable end-to-end without a backend. Setting [useRemoteApi] routes
/// the same calls through [RemoteAuthDataSource] once the REST service
/// exists — the contract never changes.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._storage, this._remote, {this.useRemoteApi = false});

  final LocalStorageDataSource _storage;
  final RemoteAuthDataSource _remote;

  /// When the real REST backend is available, construct this repository with
  /// `useRemoteApi: true` — the contract stays identical.
  final bool useRemoteApi;

  static const String _demoUserId = 'demo-member';

  @override
  Future<AppUser?> restoreSession() async {
    final user = _storage.readSessionUser();
    final token = _storage.readSessionToken();
    if (user == null || token == null) return null;
    return user;
  }

  @override
  Future<AppUser> signInWithPassword({
    required String identifier,
    required String password,
  }) async {
    if (identifier.trim().isEmpty) {
      throw const AuthException('Enter your email or mobile number');
    }
    if (password.length < 6) {
      throw const AuthException('Password must be at least 6 characters');
    }
    if (useRemoteApi) {
      final remoteUser = await _remote.signIn(
        identifier: identifier,
        password: password,
      );
      _persist(remoteUser);
      return remoteUser;
    }
    final user = _demoUser(identifier);
    _persist(user);
    return user;
  }

  @override
  Future<String> requestOtp({required String phone}) async {
    if (phone.replaceAll(RegExp(r'\D'), '').length != 10) {
      throw const AuthException('Enter a valid 10-digit mobile number');
    }
    // In production this would call the SMS gateway; the demo returns the
    // code so the UI can surface it for reviewers.
    return '${Random.secure().nextInt(900000) + 100000}';
  }

  @override
  Future<AppUser> verifyOtp({
    required String phone,
    required String code,
  }) async {
    if (code.trim().length != 6) {
      throw const AuthException('Enter the 6-digit code we sent you');
    }
    final user = _demoUser(phone);
    _persist(user);
    return user;
  }

  @override
  Future<AppUser> register(RegisterFormData data) async {
    if (useRemoteApi) {
      final remoteUser = await _remote.register(data);
      _persist(remoteUser);
      return remoteUser;
    }
    final user = AppUser(
      id: _storage.newId('u'),
      fullName: data.fullName,
      email: data.email,
      phone: data.phone,
      gender: data.gender,
      religion: data.religion,
      community: data.community,
      motherTongue: data.motherTongue,
      city: data.city,
      education: data.education,
      profession: data.profession,
      about: data.about,
      createdAt: DateTime.now(),
    );
    _persist(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    await Future<void>.delayed(Duration.zero);
    _storage.clearSession();
  }

  void _persist(AppUser user) {
    _storage.writeSession(token: _storage.newId('tok'), user: user);
  }

  AppUser _demoUser(String identifier) {
    final isEmail = identifier.contains('@');
    final derivedName = isEmail
        ? identifier.split('@').first
            .replaceAll(RegExp(r'[._\-\d]+'), ' ')
            .trim()
        : 'Royal Member';
    final prettyName = derivedName.isEmpty || derivedName.length < 2
        ? 'Royal Member'
        : derivedName
            .split(' ')
            .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
            .join(' ');
    return AppUser(
      id: _demoUserId,
      fullName: prettyName,
      email: isEmail ? identifier : '$identifier@vivaahroyal.demo',
      phone: isEmail ? null : identifier,
      gender: Gender.male,
      createdAt: DateTime.now(),
    );
  }
}
