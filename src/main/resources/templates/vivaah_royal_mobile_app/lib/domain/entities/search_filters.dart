import 'profile.dart';

/// Immutable, copyable set of search criteria.
///
/// `matches` holds the actual filtering logic so it can be unit-tested in
/// isolation (see `test/search_filters_test.dart`).
class SearchFilters {
  const SearchFilters({
    this.query = '',
    this.gender,
    this.minAge = 21,
    this.maxAge = 60,
    this.minHeightCm = 140,
    this.maxHeightCm = 200,
    this.maritalStatuses = const <MaritalStatus>{},
    this.religion,
    this.motherTongue,
    this.country,
    this.city,
    this.education,
    this.profession,
    this.diet,
    this.maxIncomeLakh,
    this.verifiedOnly = false,
  });

  final String query;
  final Gender? gender;
  final int minAge;
  final int maxAge;
  final int minHeightCm;
  final int maxHeightCm;
  final Set<MaritalStatus> maritalStatuses;
  final String? religion;
  final String? motherTongue;
  final String? country;
  final String? city;
  final String? education;
  final String? profession;
  final Diet? diet;
  final int? maxIncomeLakh;
  final bool verifiedOnly;

  bool get isEmpty =>
      query.isEmpty &&
      gender == null &&
      minAge == 21 &&
      maxAge == 60 &&
      minHeightCm == 140 &&
      maxHeightCm == 200 &&
      maritalStatuses.isEmpty &&
      religion == null &&
      motherTongue == null &&
      country == null &&
      city == null &&
      education == null &&
      profession == null &&
      diet == null &&
      maxIncomeLakh == null &&
      !verifiedOnly;

  int get activeCount {
    var count = 0;
    if (query.isNotEmpty) count++;
    if (gender != null) count++;
    if (minAge != 21 || maxAge != 60) count++;
    if (minHeightCm != 140 || maxHeightCm != 200) count++;
    if (maritalStatuses.isNotEmpty) count++;
    if (religion != null) count++;
    if (motherTongue != null) count++;
    if (country != null) count++;
    if (city != null) count++;
    if (education != null) count++;
    if (profession != null) count++;
    if (diet != null) count++;
    if (maxIncomeLakh != null) count++;
    if (verifiedOnly) count++;
    return count;
  }

  /// Returns true when [profile] satisfies every configured criterion.
  bool matches(Profile profile) {
    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      final haystack = <String>[
        profile.fullName,
        profile.city,
        profile.profession,
        profile.education,
        profile.religion,
        profile.community,
        profile.motherTongue,
      ];
      if (!haystack.any((field) => field.toLowerCase().contains(q))) {
        return false;
      }
    }
    if (gender != null && profile.gender != gender) return false;
    if (profile.age < minAge || profile.age > maxAge) return false;
    if (profile.heightCm < minHeightCm || profile.heightCm > maxHeightCm) {
      return false;
    }
    if (maritalStatuses.isNotEmpty &&
        !maritalStatuses.contains(profile.maritalStatus)) {
      return false;
    }
    if (religion != null && profile.religion != religion) return false;
    if (motherTongue != null && profile.motherTongue != motherTongue) {
      return false;
    }
    if (country != null && profile.country != country) return false;
    if (city != null && profile.city != city) return false;
    if (education != null && profile.education != education) return false;
    if (profession != null && profile.profession != profession) return false;
    if (diet != null && profile.diet != diet) return false;
    if (maxIncomeLakh != null &&
        profile.annualIncomeLakh > maxIncomeLakh!) {
      return false;
    }
    if (verifiedOnly && !profile.isVerified) return false;
    return true;
  }

  SearchFilters copyWith({
    String? query,
    Object? gender = _sentinel,
    int? minAge,
    int? maxAge,
    int? minHeightCm,
    int? maxHeightCm,
    Set<MaritalStatus>? maritalStatuses,
    Object? religion = _sentinel,
    Object? motherTongue = _sentinel,
    Object? country = _sentinel,
    Object? city = _sentinel,
    Object? education = _sentinel,
    Object? profession = _sentinel,
    Object? diet = _sentinel,
    Object? maxIncomeLakh = _sentinel,
    bool? verifiedOnly,
  }) {
    return SearchFilters(
      query: query ?? this.query,
      gender: gender == _sentinel ? this.gender : gender as Gender?,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      minHeightCm: minHeightCm ?? this.minHeightCm,
      maxHeightCm: maxHeightCm ?? this.maxHeightCm,
      maritalStatuses: maritalStatuses ?? this.maritalStatuses,
      religion:
          religion == _sentinel ? this.religion : religion as String?,
      motherTongue: motherTongue == _sentinel
          ? this.motherTongue
          : motherTongue as String?,
      country: country == _sentinel ? this.country : country as String?,
      city: city == _sentinel ? this.city : city as String?,
      education:
          education == _sentinel ? this.education : education as String?,
      profession: profession == _sentinel
          ? this.profession
          : profession as String?,
      diet: diet == _sentinel ? this.diet : diet as Diet?,
      maxIncomeLakh: maxIncomeLakh == _sentinel
          ? this.maxIncomeLakh
          : maxIncomeLakh as int?,
      verifiedOnly: verifiedOnly ?? this.verifiedOnly,
    );
  }

  static const Object _sentinel = Object();
}
