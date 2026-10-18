import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/api_client.dart';
import 'data/datasources/local_storage_data_source.dart';
import 'data/datasources/mock_data_source.dart';
import 'data/datasources/remote_auth_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/chat_repository_impl.dart';
import 'data/repositories/membership_repository_impl.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/chat_repository.dart';
import 'domain/repositories/membership_repository.dart';
import 'domain/repositories/profile_repository.dart';

/// ── Composition root ───────────────────────────────────────────────────────
/// Every dependency in the app is wired here through Riverpod providers.
/// Swapping any implementation (e.g. mock → REST) is a one-line change.

/// Overridden in `main()` with the real preferences cache before
/// [ProviderScope] mounts the widget tree.
final sharedPreferencesProvider = Provider<SharedPreferencesWithCache>(
  (ref) => throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in main()',
  ),
);

// ── Data sources ─────────────────────────────────────────────────────────────

final mockDataSourceProvider =
    Provider<MockDataSource>((ref) => const MockDataSource());

final localStorageDataSourceProvider = Provider<LocalStorageDataSource>(
  (ref) => LocalStorageDataSource(ref.watch(sharedPreferencesProvider)),
);

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final remoteAuthDataSourceProvider = Provider<RemoteAuthDataSource>(
  (ref) => RemoteAuthDataSource(ref.watch(apiClientProvider)),
);

// ── Repositories (domain contracts → data implementations) ──────────────────

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.watch(localStorageDataSourceProvider),
    ref.watch(remoteAuthDataSourceProvider),
  ),
);

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepositoryImpl(
    ref.watch(mockDataSourceProvider),
    ref.watch(localStorageDataSourceProvider),
  ),
);

final chatRepositoryProvider = Provider<ChatRepository>(
  (ref) => ChatRepositoryImpl(
    ref.watch(mockDataSourceProvider),
    ref.watch(localStorageDataSourceProvider),
  ),
);

final membershipRepositoryProvider = Provider<MembershipRepository>(
  (ref) => MembershipRepositoryImpl(ref.watch(mockDataSourceProvider)),
);
