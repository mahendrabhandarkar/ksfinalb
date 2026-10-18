import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/profile.dart';
import '../../domain/entities/search_filters.dart';
import 'profiles_controller.dart';

/// Search ViewModel: owns the active [SearchFilters] and exposes the
/// filtered result set as a derived provider.
class SearchFiltersController extends Notifier<SearchFilters> {
  @override
  SearchFilters build() => const SearchFilters();

  void apply(SearchFilters filters) => state = filters;

  void reset() => state = const SearchFilters();
}

final searchFiltersControllerProvider =
    NotifierProvider<SearchFiltersController, SearchFilters>(
  SearchFiltersController.new,
);

/// Profiles matching the current filters. Recomputed only when the
/// catalogue or a filter changes.
final searchResultsProvider = Provider<List<Profile>>((ref) {
  final profiles =
      ref.watch(profilesControllerProvider).value ?? const <Profile>[];
  final filters = ref.watch(searchFiltersControllerProvider);
  return profiles.where(filters.matches).toList(growable: false);
});
