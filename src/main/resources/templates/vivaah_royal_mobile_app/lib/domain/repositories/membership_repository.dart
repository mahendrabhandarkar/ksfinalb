import '../entities/membership_plan.dart';

/// Contract for membership plans and checkout.
abstract interface class MembershipRepository {
  /// Available tiers, ordered Gold → Diamond → Platinum.
  Future<List<MembershipPlan>> fetchPlans();

  /// Simulated checkout. Returns a receipt string to show the member.
  Future<String> purchase({
    required MembershipPlan plan,
    required PlanDuration duration,
  });
}
