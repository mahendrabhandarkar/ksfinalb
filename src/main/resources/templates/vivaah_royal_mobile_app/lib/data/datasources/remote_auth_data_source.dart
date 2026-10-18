import 'package:dio/dio.dart';

import '../../core/errors/app_exceptions.dart';
import '../../core/network/api_client.dart';
import '../../domain/entities/user.dart';
import '../mappers/user_mapper.dart';

/// REST implementation of the auth endpoints (ready for the real backend).
///
/// The demo repositories do not call this class by default — they run on the
/// mock/local data source so the app is fully functional offline. To go live:
///   1. Point `AppConstants.apiBaseUrl` at the real API.
///   2. In `AuthRepositoryImpl`, route calls through [RemoteAuthDataSource].
class RemoteAuthDataSource {
  RemoteAuthDataSource(this._client);

  final ApiClient _client;

  Future<AppUser> signIn({
    required String identifier,
    required String password,
  }) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        '/auth/login',
        data: <String, dynamic>{'identifier': identifier, 'password': password},
      );
      final data = response.data ?? <String, dynamic>{};
      return UserMapper.fromApiJson(
        data['user'] as Map<String, dynamic>? ?? data,
      );
    } on DioException catch (e) {
      throw _map(e);
    }
  }

  Future<AppUser> register(RegisterFormData data) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        '/auth/register',
        data: UserMapper.formToJson(data),
      );
      final body = response.data ?? <String, dynamic>{};
      return UserMapper.fromApiJson(
        body['user'] as Map<String, dynamic>? ?? body,
      );
    } on DioException catch (e) {
      throw _map(e);
    }
  }

  AppException _map(DioException e) {
    final code = e.response?.statusCode ?? 0;
    if (code == 401 || code == 403) {
      return const AuthException('Invalid email or password');
    }
    if (code == 409) {
      return const AuthException('An account with these details exists');
    }
    final isTimeout = e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout;
    if (isTimeout || e.type == DioExceptionType.connectionError) {
      return const NetworkException('No connection. Please try again.');
    }
    return AuthException(
      code == 0 ? 'Network error. Please try again.' : 'Request failed ($code)',
    );
  }
}
