import 'profile.dart';

/// The signed-in member of the app (distinct from [Profile], which is a
/// browsable match).
class AppUser {
  const AppUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.gender,
    required this.createdAt,
    this.phone,
    this.religion,
    this.community,
    this.motherTongue,
    this.city,
    this.education,
    this.profession,
    this.about,
  });

  final String id;
  final String fullName;
  final String email;
  final String? phone;
  final Gender gender;
  final String? religion;
  final String? community;
  final String? motherTongue;
  final String? city;
  final String? education;
  final String? profession;
  final String? about;
  final DateTime createdAt;

  String get firstName {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    return parts.isEmpty ? fullName : parts.first;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'gender': gender.name,
        'religion': religion,
        'community': community,
        'motherTongue': motherTongue,
        'city': city,
        'education': education,
        'profession': profession,
        'about': about,
        'createdAt': createdAt.toIso8601String(),
      };

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json['id'] as String,
        fullName: json['fullName'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String?,
        gender: GenderX.parse(json['gender'] as String?),
        religion: json['religion'] as String?,
        community: json['community'] as String?,
        motherTongue: json['motherTongue'] as String?,
        city: json['city'] as String?,
        education: json['education'] as String?,
        profession: json['profession'] as String?,
        about: json['about'] as String?,
        createdAt:
            DateTime.tryParse(json['createdAt'] as String? ?? '') ??
                DateTime.fromMillisecondsSinceEpoch(0),
      );

  @override
  bool operator ==(Object other) => other is AppUser && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Immutable payload collected by the multi-step registration form.
class RegisterFormData {
  const RegisterFormData({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.religion,
    required this.community,
    required this.motherTongue,
    required this.education,
    required this.profession,
    required this.city,
    required this.maritalStatus,
    required this.diet,
    required this.about,
  });

  final String fullName;
  final String email;
  final String phone;
  final Gender gender;
  final String religion;
  final String community;
  final String motherTongue;
  final String education;
  final String profession;
  final String city;
  final MaritalStatus maritalStatus;
  final Diet diet;
  final String about;
}
