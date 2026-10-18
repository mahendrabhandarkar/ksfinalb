import 'package:dio/dio.dart';

import '../constants/app_constants.dart';

/// Configured [Dio] wrapper for the (future) Vivaah Royal REST backend.
///
/// The demo repositories intentionally run on the mock data source so the
/// app works offline out of the box. When the real backend is ready, flip
/// [RemoteAuthDataSource] usage inside `AuthRepositoryImpl` and this client
/// is already wired with base URL, timeouts, auth header and logging.
class ApiClient {
  ApiClient({String? baseUrl, String Function()? tokenProvider})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? AppConstants.apiBaseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 20),
            sendTimeout: const Duration(seconds: 15),
            headers: <String, String>{'Accept': 'application/json'},
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = tokenProvider?.call();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
    _dio.interceptors.add(
      LogInterceptor(requestBody: false, responseBody: false),
    );
  }

  final Dio _dio;

  Dio get dio => _dio;
}
