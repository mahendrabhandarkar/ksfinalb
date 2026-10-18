import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/membership_plan.dart';
import '../../controllers/membership_controller.dart';

/// Membership screen: duration toggle, three royal tiers and simulated
/// checkout with a receipt confirmation.
class MembershipScreen extends ConsumerWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(membershipPlansProvider);
    final selection = ref.watch(membershipSelectionProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Royal Memberships')),
      body: plans.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
        data: (plans) => ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
          children: [
            Text(
              'Unlock deeper connections',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 6),
            Text(
              'Choose a tier and billing period. Upgrade, downgrade or cancel '
              'any time.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 18),
            SegmentedButton<PlanDuration>(
              segments: PlanDuration.values
                  .map(
                    (d) => ButtonSegment(
                      value: d,
                      label: Text(d.label),
                    ),
                  )
                  .toList(),
              selected: {selection.duration},
              onSelectionChanged: (set) => ref
                  .read(membershipSelectionProvider.notifier)
                  .selectDuration(set.first),
            ),
            const SizedBox(height: 20),
            for (final plan in plans) ...[
              _PlanCard(plan: plan, selection: selection),
              const SizedBox(height: 14),
            ],
            const SizedBox(height: 6),
            Text(
              'Prices are indicative for the design demo. Payments will be '
              'processed securely via UPI / cards in the production build.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends ConsumerWidget {
  const _PlanCard({required this.plan, required this.selection});

  final MembershipPlan plan;
  final MembershipSelection selection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selected = selection.planId == plan.id;
    final duration = selection.duration;
    final monthly = plan.pricePerMonthInr;
    final total = (monthly * duration.months * (100 - duration.discountPercent) ~/ 100);
    final price = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: selected ? AppColors.crimson : AppColors.outline,
          width: selected ? 1.8 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () =>
            ref.read(membershipSelectionProvider.notifier).selectPlan(plan.id),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.workspace_premium_rounded,
                              size: 20,
                              color: selected
                                  ? AppColors.crimson
                                  : AppColors.gold,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              plan.name,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (plan.isPopular)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.goldContainer,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'MOST CHOSEN',
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.onGoldContainer,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          plan.tagline,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        price.format(total),
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: AppColors.crimson,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'for ${duration.months} months'
                        '${duration.discountPercent > 0 ? ' · ${duration.discountPercent}% off' : ''}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 24),
              ...plan.features.map(
                (feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_rounded,
                          size: 17, color: AppColors.success),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          feature,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: selected
                    ? FilledButton.icon(
                        onPressed: () => _purchase(context, ref),
                        icon: const Icon(Icons.verified_rounded),
                        label: Text(
                            'Choose ${plan.name} — ${price.format(total)}'),
                      )
                    : OutlinedButton(
                        onPressed: () => ref
                            .read(membershipSelectionProvider.notifier)
                            .selectPlan(plan.id),
                        child: const Text('Select this plan'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _purchase(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Upgrade to ${plan.name}?'),
        content: Text(
          'This is a design demo — no payment will be processed. Continue to '
          'simulate activation?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final receipt = await ref
        .read(membershipSelectionProvider.notifier)
        .purchase(plan);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Welcome to ${plan.name}! Receipt $receipt (demo).'),
      ),
    );
  }
}
