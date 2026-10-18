/// A paid membership tier offered by Vivaah Royal.
class MembershipPlan {
  const MembershipPlan({
    required this.id,
    required this.name,
    required this.tagline,
    required this.pricePerMonthInr,
    required this.features,
    required this.isPopular,
  });

  final String id;
  final String name;
  final String tagline;
  final int pricePerMonthInr;
  final List<String> features;
  final bool isPopular;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'tagline': tagline,
        'pricePerMonthInr': pricePerMonthInr,
        'features': features,
        'isPopular': isPopular,
      };

  factory MembershipPlan.fromJson(Map<String, dynamic> json) =>
      MembershipPlan(
        id: json['id'] as String,
        name: json['name'] as String,
        tagline: json['tagline'] as String? ?? '',
        pricePerMonthInr: json['pricePerMonthInr'] as int,
        features: (json['features'] as List<dynamic>? ?? const <dynamic>[])
            .whereType<String>()
            .toList(growable: false),
        isPopular: json['isPopular'] as bool? ?? false,
      );

  @override
  bool operator ==(Object other) => other is MembershipPlan && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Billing duration selectable on the membership screen.
enum PlanDuration {
  three(3, 0),
  six(6, 10),
  twelve(12, 20);

  const PlanDuration(this.months, this.discountPercent);

  final int months;
  final int discountPercent;

  String get label => '$months Months';
}

/// User selection on the membership screen: plan + billing duration.
class MembershipSelection {
  const MembershipSelection({
    required this.planId,
    required this.duration,
  });

  final String planId;
  final PlanDuration duration;

  MembershipSelection copyWith({
    String? planId,
    PlanDuration? duration,
  }) {
    return MembershipSelection(
      planId: planId ?? this.planId,
      duration: duration ?? this.duration,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is MembershipSelection &&
      other.planId == planId &&
      other.duration == duration;

  @override
  int get hashCode => Object.hash(planId, duration);
}
