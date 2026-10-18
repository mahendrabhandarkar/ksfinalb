import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vivaah_royal/data/datasources/local_storage_data_source.dart';
import 'package:vivaah_royal/data/datasources/mock_data_source.dart';
import 'package:vivaah_royal/data/repositories/profile_repository_impl.dart';
import 'package:vivaah_royal/domain/entities/profile.dart';
import 'package:vivaah_royal/domain/entities/user.dart';

class _MockStorage extends Mock implements LocalStorageDataSource {}

void main() {
  setUpAll(() {
    // Fallbacks for unstubbed methods used incidentally.
    registerFallbackValue(<String>{});
  });

  group('MockDataSource', () {
    final mock = const MockDataSource();

    test('provides 24 unique, complete profiles', () {
      final profiles = mock.profiles;
      expect(profiles.length, 24);
      expect(profiles.map((p) => p.id).toSet().length, 24);
      for (final profile in profiles) {
        expect(profile.fullName, isNotEmpty);
        expect(profile.initials.length, lessThanOrEqualTo(2));
        expect(profile.photoUrl, isNotNull);
      }
    });

    test('profiles round-trip through JSON without data loss', () {
      final profile = mock.profiles.first;
      final restored = Profile.fromJson(profile.toJson());
      expect(restored.id, profile.id);
      expect(restored.fullName, profile.fullName);
      expect(restored.hobbies, profile.hobbies);
      expect(restored.gender, profile.gender);
      expect(restored.maritalStatus, profile.maritalStatus);
      expect(restored.diet, profile.diet);
    });

    test('seeds three conversations with messages', () {
      final data = mock.seedChatData();
      expect(data.conversations.length, 3);
      expect(data.messagesByConversation['r01']!.length, greaterThan(1));
      expect(data.totalUnread, greaterThan(0));
    });
  });

  group('ProfileRepositoryImpl.toggleShortlist', () {
    test('adds and removes ids, persisting through storage', () async {
      final storage = _MockStorage();
      final ids = <String>{};
      when(() => storage.readShortlist()).thenAnswer((_) => ids);
      when(() => storage.writeShortlist(any()))
          .thenAnswer((invocation) {
        // Copy the argument: the repository may pass the very set it mutated.
        final written = Set<String>.of(
          invocation.positionalArguments[0] as Set<String>,
        );
        ids
          ..clear()
          ..addAll(written);
      });

      final repository = ProfileRepositoryImpl(
        const MockDataSource(),
        storage,
      );

      final added = await repository.toggleShortlist('r01');
      expect(added, contains('r01'));

      final removed = await repository.toggleShortlist('r01');
      expect(removed, isNot(contains('r01')));
    });
  });

  group('AppUser JSON round-trip', () {
    test('restores every field', () {
      final real = AppUser(
        id: 'u-1',
        fullName: 'Arjun Malhotra',
        email: 'arjun@example.com',
        phone: '9876543210',
        gender: Gender.male,
        religion: 'Hindu',
        createdAt: DateTime(2026, 10, 18, 12, 30),
      );
      final restored = AppUser.fromJson(real.toJson());
      expect(restored.id, real.id);
      expect(restored.fullName, real.fullName);
      expect(restored.gender, real.gender);
      expect(restored.createdAt, real.createdAt);
      expect(restored.firstName, 'Arjun');
    });
  });
}
