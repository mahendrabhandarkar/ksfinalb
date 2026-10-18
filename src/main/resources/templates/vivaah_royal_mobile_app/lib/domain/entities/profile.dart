/// Gender of a matrimony profile.
enum Gender { male, female }

/// Marital status as required by matrimony listings.
enum MaritalStatus { neverMarried, divorced, widowed, awaitingDivorce }

/// Dietary preference, commonly filtered in Indian matrimony searches.
enum Diet { vegetarian, nonVegetarian, eggetarian, vegan, jain }

extension GenderX on Gender {
  String get label => switch (this) {
        Gender.male => 'Male',
        Gender.female => 'Female',
      };

  String get jsonName => name;

  static Gender parse(String? value) => Gender.values.firstWhere(
        (g) => g.name == value,
        orElse: () => Gender.male,
      );
}

extension MaritalStatusX on MaritalStatus {
  String get label => switch (this) {
        MaritalStatus.neverMarried => 'Never Married',
        MaritalStatus.divorced => 'Divorced',
        MaritalStatus.widowed => 'Widowed',
        MaritalStatus.awaitingDivorce => 'Awaiting Divorce',
      };

  static MaritalStatus parse(String? value) =>
      MaritalStatus.values.firstWhere(
        (m) => m.name == value,
        orElse: () => MaritalStatus.neverMarried,
      );
}

extension DietX on Diet {
  String get label => switch (this) {
        Diet.vegetarian => 'Vegetarian',
        Diet.nonVegetarian => 'Non-Vegetarian',
        Diet.eggetarian => 'Eggetarian',
        Diet.vegan => 'Vegan',
        Diet.jain => 'Jain',
      };

  static Diet parse(String? value) => Diet.values.firstWhere(
        (d) => d.name == value,
        orElse: () => Diet.vegetarian,
      );
}

/// A matrimonial profile shown in feeds, search results and chat.
class Profile {
  const Profile({
    required this.id,
    required this.fullName,
    required this.gender,
    required this.age,
    required this.heightCm,
    required this.religion,
    required this.community,
    required this.motherTongue,
    required this.maritalStatus,
    required this.city,
    required this.country,
    required this.education,
    required this.profession,
    required this.annualIncomeLakh,
    required this.diet,
    required this.about,
    required this.hobbies,
    required this.isPremium,
    required this.isVerified,
    required this.lastActiveAt,
    this.photoUrl,
  });

  final String id;
  final String fullName;
  final Gender gender;
  final int age;
  final int heightCm;
  final String religion;
  final String community;
  final String motherTongue;
  final MaritalStatus maritalStatus;
  final String city;
  final String country;
  final String education;
  final String profession;
  final int annualIncomeLakh;
  final Diet diet;
  final String about;
  final List<String> hobbies;
  final bool isPremium;
  final bool isVerified;
  final DateTime lastActiveAt;
  final String? photoUrl;

  String get initials {
    final parts = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList(growable: false);
    if (parts.isEmpty) return '?';
    final first = parts.first[0];
    final last = parts.length > 1 ? parts.last[0] : '';
    return (first + last).toUpperCase();
  }

  String get locationLabel => '$city, $country';

  String get headline => '$education · $profession';

  Profile copyWith({
    String? id,
    String? fullName,
    Gender? gender,
    int? age,
    int? heightCm,
    String? religion,
    String? community,
    String? motherTongue,
    MaritalStatus? maritalStatus,
    String? city,
    String? country,
    String? education,
    String? profession,
    int? annualIncomeLakh,
    Diet? diet,
    String? about,
    List<String>? hobbies,
    bool? isPremium,
    bool? isVerified,
    DateTime? lastActiveAt,
    String? photoUrl,
  }) {
    return Profile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      heightCm: heightCm ?? this.heightCm,
      religion: religion ?? this.religion,
      community: community ?? this.community,
      motherTongue: motherTongue ?? this.motherTongue,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      city: city ?? this.city,
      country: country ?? this.country,
      education: education ?? this.education,
      profession: profession ?? this.profession,
      annualIncomeLakh: annualIncomeLakh ?? this.annualIncomeLakh,
      diet: diet ?? this.diet,
      about: about ?? this.about,
      hobbies: hobbies ?? this.hobbies,
      isPremium: isPremium ?? this.isPremium,
      isVerified: isVerified ?? this.isVerified,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'fullName': fullName,
        'gender': gender.name,
        'age': age,
        'heightCm': heightCm,
        'religion': religion,
        'community': community,
        'motherTongue': motherTongue,
        'maritalStatus': maritalStatus.name,
        'city': city,
        'country': country,
        'education': education,
        'profession': profession,
        'annualIncomeLakh': annualIncomeLakh,
        'diet': diet.name,
        'about': about,
        'hobbies': hobbies,
        'isPremium': isPremium,
        'isVerified': isVerified,
        'lastActiveAt': lastActiveAt.toIso8601String(),
        'photoUrl': photoUrl,
      };

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json['id'] as String,
        fullName: json['fullName'] as String,
        gender: GenderX.parse(json['gender'] as String?),
        age: json['age'] as int,
        heightCm: json['heightCm'] as int,
        religion: json['religion'] as String,
        community: json['community'] as String,
        motherTongue: json['motherTongue'] as String,
        maritalStatus: MaritalStatusX.parse(json['maritalStatus'] as String?),
        city: json['city'] as String,
        country: json['country'] as String,
        education: json['education'] as String,
        profession: json['profession'] as String,
        annualIncomeLakh: json['annualIncomeLakh'] as int,
        diet: DietX.parse(json['diet'] as String?),
        about: json['about'] as String? ?? '',
        hobbies: (json['hobbies'] as List<dynamic>? ?? const <dynamic>[])
            .whereType<String>()
            .toList(growable: false),
        isPremium: json['isPremium'] as bool? ?? false,
        isVerified: json['isVerified'] as bool? ?? false,
        lastActiveAt:
            DateTime.tryParse(json['lastActiveAt'] as String? ?? '') ??
                DateTime.fromMillisecondsSinceEpoch(0),
        photoUrl: json['photoUrl'] as String?,
      );

  @override
  bool operator ==(Object other) => other is Profile && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
