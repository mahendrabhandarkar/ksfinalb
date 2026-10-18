import 'package:flutter_test/flutter_test.dart';
import 'package:vivaah_royal/domain/entities/profile.dart';
import 'package:vivaah_royal/domain/entities/search_filters.dart';

Profile _profile({
  int age = 27,
  Gender gender = Gender.female,
  int heightCm = 165,
  String religion = 'Hindu',
  String city = 'Pune',
  String profession = 'Software Engineer',
  Diet diet = Diet.vegetarian,
  bool verified = true,
  MaritalStatus maritalStatus = MaritalStatus.neverMarried,
  String name = 'Ananya Deshmukh',
}) {
  return Profile(
    id: 'test-1',
    fullName: name,
    gender: gender,
    age: age,
    heightCm: heightCm,
    religion: religion,
    community: 'Marathi',
    motherTongue: 'Marathi',
    maritalStatus: maritalStatus,
    city: city,
    country: 'India',
    education: 'M.Tech',
    profession: profession,
    annualIncomeLakh: 18,
    diet: diet,
    about: 'Test profile',
    hobbies: const ['Reading'],
    isPremium: false,
    isVerified: verified,
    lastActiveAt: DateTime(2026, 1, 1),
  );
}

void main() {
  group('SearchFilters.activeCount', () {
    test('is zero for default filters', () {
      expect(const SearchFilters().activeCount, 0);
      expect(const SearchFilters().isEmpty, isTrue);
    });

    test('counts each configured criterion', () {
      final filters = const SearchFilters().copyWith(
        gender: Gender.female,
        minAge: 24,
        religion: 'Hindu',
        verifiedOnly: true,
      );
      expect(filters.activeCount, 4);
    });
  });

  group('SearchFilters.matches', () {
    test('matches within age and height ranges', () {
      const filters = SearchFilters();
      expect(filters.matches(_profile()), isTrue);

      final narrow = const SearchFilters().copyWith(minAge: 28);
      expect(narrow.matches(_profile()), isFalse);
    });

    test('keyword search spans name, city and profession', () {
      expect(
        const SearchFilters().copyWith(query: 'pune').matches(_profile()),
        isTrue,
      );
      expect(
        const SearchFilters()
            .copyWith(query: 'Cardiologist')
            .matches(_profile()),
        isFalse,
      );
    });

    test('gender and religion filter strictly', () {
      final filters = const SearchFilters().copyWith(
        gender: Gender.male,
        religion: 'Muslim',
      );
      expect(filters.matches(_profile()), isFalse);
    });

    test('verifiedOnly excludes unverified profiles', () {
      expect(
        const SearchFilters()
            .copyWith(verifiedOnly: true)
            .matches(_profile(verified: false)),
        isFalse,
      );
    });

    test('marital status set is honoured', () {
      final filters = const SearchFilters()
          .copyWith(maritalStatuses: {MaritalStatus.divorced});
      expect(filters.matches(_profile()), isFalse);
      expect(filters.matches(_profile(maritalStatus: MaritalStatus.divorced)),
          isTrue);
    });

    test('diet filter is respected', () {
      expect(
        const SearchFilters().copyWith(diet: Diet.vegan).matches(_profile()),
        isFalse,
      );
      expect(
        const SearchFilters()
            .copyWith(diet: Diet.vegetarian)
            .matches(_profile()),
        isTrue,
      );
    });
  });
}
