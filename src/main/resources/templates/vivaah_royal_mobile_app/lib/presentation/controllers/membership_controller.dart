import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di.dart';
import '../../domain/entities/membership_plan.dart';

/// Membership ViewModel: plan catalogue + the member's current selection.
class MembershipPlansController extends AsyncNotifier<List<MembershipPlan>> {
  @override
  Future<List<MembershipPlan>> build() {
    return ref.watch(membershipRepositoryProvider).fetchPlans();
  }
}

final membershipPlansProvider =
    AsyncNotifierProvider<MembershipPlansController, List<MembershipPlan>>(
  MembershipPlansController.new,
);

/// Selected plan + billing duration shown on the membership screen.
class MembershipSelectionController extends Notifier<MembershipSelection> {
  @override
  MembershipSelection build() {
    return const MembershipSelection(
      planId: 'diamond',
      duration: PlanDuration.six,
    );
  }

  void selectPlan(String planId) =>
      state = state.copyWith(planId: planId);

  void selectDuration(PlanDuration duration) =>
      state = state.copyWith(duration: duration);

  /// Simulated checkout using the currently selected billing duration.
  /// Returns the receipt id shown to the member.
  Future<String> purchase(MembershipPlan plan) {
    final repository = ref.read(membershipRepositoryProvider);
    return repository.purchase(plan: plan, duration: state.duration);
  }
}

final membershipSelectionProvider =
    NotifierProvider<MembershipSelectionController, MembershipSelection>(
  MembershipSelectionController.new,
);
