import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/profile.dart';
import '../../../domain/entities/search_filters.dart';
import '../../controllers/profiles_controller.dart';
import '../../controllers/search_controller.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/profile_card.dart';

/// Search with a rich filter sheet. Filters live in [SearchFiltersController];
/// results stream through the derived [searchResultsProvider].
class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(searchResultsProvider);
    final filters = ref.watch(searchFiltersControllerProvider);
    final asyncProfiles = ref.watch(profilesControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find your match'),
        actions: [
          if (filters.activeCount > 0)
            TextButton(
              onPressed: () =>
                  ref.read(searchFiltersControllerProvider.notifier).reset(),
              child: const Text('Reset'),
            ),
          Badge(
            isLabelVisible: filters.activeCount > 0,
            label: Text('${filters.activeCount}'),
            backgroundColor: AppColors.crimson,
            child: IconButton(
              tooltip: 'Filters',
              onPressed: () => _showFilterSheet(context, ref, filters),
              icon: const Icon(Icons.tune_rounded),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: asyncProfiles.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => EmptyState(
          icon: Icons.error_outline_rounded,
          title: 'Something went wrong',
          message: '$error',
          actionLabel: 'Retry',
          onAction: () =>
              ref.read(profilesControllerProvider.notifier).refresh(),
        ),
        data: (_) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Row(
                children: [
                  Text(
                    '${results.length} ${results.length == 1 ? 'profile' : 'profiles'}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  if (filters.query.isNotEmpty)
                    _ActiveFilterChip(
                      label: '“${filters.query}”',
                      onRemove: () => ref
                          .read(searchFiltersControllerProvider.notifier)
                          .apply(filters.copyWith(query: '')),
                    ),
                  if (filters.gender != null)
                    _ActiveFilterChip(
                      label: filters.gender!.label,
                      onRemove: () => ref
                          .read(searchFiltersControllerProvider.notifier)
                          .apply(filters.copyWith(gender: null)),
                    ),
                ],
              ),
            ),
            Expanded(
              child: results.isEmpty
                  ? EmptyState(
                      icon: Icons.person_search_rounded,
                      title: 'No profiles match',
                      message:
                          'Try relaxing a filter — smaller age gaps or broader '
                          'communities surface more matches.',
                      actionLabel: 'Reset filters',
                      onAction: () => ref
                          .read(searchFiltersControllerProvider.notifier)
                          .reset(),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      itemCount: results.length,
                      itemBuilder: (context, index) => ProfileTile(
                        profile: results[index],
                        onTap: () => context.push(
                          RouteNames.profileFor(results[index].id),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterSheet(
    BuildContext context,
    WidgetRef ref,
    SearchFilters current,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _FilterSheet(initial: current),
    );
  }
}

class _ActiveFilterChip extends StatelessWidget {
  const _ActiveFilterChip({required this.label, required this.onRemove});

  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: InputChip(
        label: Text(label),
        visualDensity: VisualDensity.compact,
        onDeleted: onRemove,
        deleteIconColor: AppColors.muted,
      ),
    );
  }
}

class _FilterSheet extends ConsumerStatefulWidget {
  const _FilterSheet({required this.initial});

  final SearchFilters initial;

  @override
  ConsumerState<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends ConsumerState<_FilterSheet> {
  late SearchFilters _draft = widget.initial;

  static const List<String> _religions = [
    'Hindu', 'Muslim', 'Christian', 'Sikh', 'Jain', 'Buddhist',
  ];
  static const List<String> _cities = [
    'Mumbai', 'New Delhi', 'Bengaluru', 'Hyderabad', 'Chennai', 'Pune',
    'Kolkata', 'Ahmedabad', 'Jaipur', 'Lucknow', 'Kochi', 'Goa', 'Chandigarh',
    'Gurugram',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.92,
      builder: (context, scrollController) {
        return Column(
          children: [
            Text('Refine search', style: theme.textTheme.titleLarge),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                children: [
                  TextFormField(
                    initialValue: _draft.query,
                    decoration: const InputDecoration(
                      labelText: 'Keyword',
                      prefixIcon: Icon(Icons.search_rounded),
                    ),
                    onChanged: (v) => _draft = _draft.copyWith(query: v),
                  ),
                  const SizedBox(height: 18),
                  _Label('I am looking for'),
                  SegmentedButton<Gender?>(
                    segments: const [
                      ButtonSegment(value: Gender.female, label: Text('Female')),
                      ButtonSegment(value: Gender.male, label: Text('Male')),
                    ],
                    selected: <Gender?>{
                      _draft.gender == Gender.male
                          ? Gender.male
                          : Gender.female,
                    },
                    onSelectionChanged: (selection) => setState(() =>
                        _draft = _draft.copyWith(gender: selection.first)),
                  ),
                  const SizedBox(height: 22),
                  _Label('Age — ${_draft.minAge} to ${_draft.maxAge} years'),
                  RangeSlider(
                    values: RangeValues(
                      _draft.minAge.toDouble(),
                      _draft.maxAge.toDouble(),
                    ),
                    min: 21,
                    max: 60,
                    divisions: 39,
                    onChanged: (values) => setState(() => _draft = _draft
                        .copyWith(minAge: values.start.round(), maxAge: values.end.round())),
                  ),
                  const SizedBox(height: 10),
                  _Label(
                    'Height — ${_draft.minHeightCm} to ${_draft.maxHeightCm} cm',
                  ),
                  RangeSlider(
                    values: RangeValues(
                      _draft.minHeightCm.toDouble(),
                      _draft.maxHeightCm.toDouble(),
                    ),
                    min: 140,
                    max: 200,
                    divisions: 60,
                    onChanged: (values) => setState(() => _draft = _draft.copyWith(
                        minHeightCm: values.start.round(),
                        maxHeightCm: values.end.round())),
                  ),
                  const SizedBox(height: 14),
                  _Label('Marital status'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 0,
                    children: MaritalStatus.values
                        .map(
                          (m) => FilterChip(
                            label: Text(m.label),
                            selected:
                                _draft.maritalStatuses.contains(m),
                            onSelected: (selected) {
                              final set = {..._draft.maritalStatuses};
                              selected ? set.add(m) : set.remove(m);
                              setState(
                                () => _draft =
                                    _draft.copyWith(maritalStatuses: set),
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _draft.religion,
                          decoration: const InputDecoration(
                            labelText: 'Religion',
                          ),
                          items: _religions
                              .map((r) => DropdownMenuItem(
                                  value: r, child: Text(r)))
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _draft = _draft.copyWith(religion: v)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _draft.city,
                          decoration: const InputDecoration(labelText: 'City'),
                          items: _cities
                              .map((c) => DropdownMenuItem(
                                  value: c, child: Text(c)))
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _draft = _draft.copyWith(city: v)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  DropdownButtonFormField<Diet>(
                    initialValue: _draft.diet,
                    decoration: const InputDecoration(
                      labelText: 'Diet',
                      prefixIcon: Icon(Icons.restaurant_rounded),
                    ),
                    items: Diet.values
                        .map((d) =>
                            DropdownMenuItem(value: d, child: Text(d.label)))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => _draft = _draft.copyWith(diet: v)),
                  ),
                  const SizedBox(height: 14),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: AppColors.crimson,
                    title: const Text('Verified profiles only'),
                    subtitle: const Text('Document-verified members'),
                    value: _draft.verifiedOnly,
                    onChanged: (v) =>
                        setState(() => _draft = _draft.copyWith(verifiedOnly: v)),
                  ),
                ],
              ),
            ),
            SafeArea(
              minimum: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        ref
                            .read(searchFiltersControllerProvider.notifier)
                            .reset();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Reset all'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: FilledButton(
                      onPressed: () {
                        ref
                            .read(searchFiltersControllerProvider.notifier)
                            .apply(_draft);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Apply filters'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }
}
