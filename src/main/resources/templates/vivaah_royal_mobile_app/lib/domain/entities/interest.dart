/// Lifecycle of an expression of interest sent to a profile.
enum InterestStatus { sent, accepted }

/// Record of an interest: which profile, its status and when it was sent.
class InterestRecord {
  const InterestRecord({
    required this.profileId,
    required this.status,
    required this.sentAt,
  });

  final String profileId;
  final InterestStatus status;
  final DateTime sentAt;

  InterestRecord copyWith({InterestStatus? status}) => InterestRecord(
        profileId: profileId,
        status: status ?? this.status,
        sentAt: sentAt,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'profileId': profileId,
        'status': status.name,
        'sentAt': sentAt.toIso8601String(),
      };

  factory InterestRecord.fromJson(Map<String, dynamic> json) =>
      InterestRecord(
        profileId: json['profileId'] as String,
        status: InterestStatus.values.firstWhere(
          (s) => s.name == json['status'],
          orElse: () => InterestStatus.sent,
        ),
        sentAt: DateTime.tryParse(json['sentAt'] as String? ?? '') ??
            DateTime.fromMillisecondsSinceEpoch(0),
      );

  @override
  bool operator ==(Object other) =>
      other is InterestRecord &&
      other.profileId == profileId &&
      other.status == status;

  @override
  int get hashCode => Object.hash(profileId, status);
}
