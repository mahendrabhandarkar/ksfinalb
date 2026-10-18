import '../../domain/entities/profile.dart';
import '../../domain/entities/user.dart';

/// Maps REST payloads ↔ domain entities. Keeping mapping in one place means
/// backend schema changes never leak into business logic.
abstract final class UserMapper {
  /// Accepts a flexible API payload: `{ id, full_name | fullName, ... }`.
  static AppUser fromApiJson(Map<String, dynamic> json) => AppUser(
        id: json['id'] as String,
        fullName: (json['full_name'] ?? json['fullName'] ?? '') as String,
        email: json['email'] as String,
        phone: json['phone'] as String?,
        gender: GenderX.parse((json['gender'] ?? 'male') as String?),
        religion: json['religion'] as String?,
        community: json['community'] as String?,
        motherTongue: json['mother_tongue'] as String?,
        city: json['city'] as String?,
        education: json['education'] as String?,
        profession: json['profession'] as String?,
        about: json['about'] as String?,
        createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ??
            DateTime.now(),
      );

  static Map<String, dynamic> formToJson(RegisterFormData data) =>
      <String, dynamic>{
        'full_name': data.fullName,
        'email': data.email,
        'phone': data.phone,
        'gender': data.gender.name,
        'religion': data.religion,
        'community': data.community,
        'mother_tongue': data.motherTongue,
        'education': data.education,
        'profession': data.profession,
        'city': data.city,
        'marital_status': data.maritalStatus.name,
        'diet': data.diet.name,
        'about': data.about,
      };
}
