import 'dart:math';

import '../../core/constants/app_constants.dart';
import '../../data/datasources/mock_data_source.dart';
import '../../domain/entities/membership_plan.dart';
import '../../domain/repositories/membership_repository.dart';

/// Mock implementation of [MembershipRepository].
class MembershipRepositoryImpl implements MembershipRepository {
  MembershipRepositoryImpl(this._mock);

  final MockDataSource _mock;

  @override
  Future<List<MembershipPlan>> fetchPlans() async {
    await Future<void>.delayed(AppConstants.mockNetworkLatency);
    return _mock.plans;
  }

  @override
  Future<String> purchase({
    required MembershipPlan plan,
    required PlanDuration duration,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    final receipt =
        'VR-${Random.secure().nextInt(900000) + 100000}';
    return receipt;
  }
}
