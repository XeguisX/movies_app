import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movies_app/features/movie/presentation/provider/providers.dart';
import 'package:movies_app/shared/widgets/widgets.dart';

class MovieFilters extends ConsumerWidget {
  final TextEditingController searchController;
  final List<String> uniqueGenres;

  const MovieFilters({
    super.key,
    required this.searchController,
    required this.uniqueGenres,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filters',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            labelText: 'Search by Name',
            controller: searchController,
            onChanged: (value) {
              ref.read(nameFilterProvider.notifier).state = value;
              saveFilterSettings(ref);
            },
          ),
          const SizedBox(height: 16),
          CustomDropdown(
            value: ref.watch(categoryFilterProvider.notifier).state,
            items: <String>['All', ...uniqueGenres],
            onChanged: (value) {
              ref.read(categoryFilterProvider.notifier).state = value!;
              saveFilterSettings(ref);
            },
          ),
        ],
      ),
    );
  }
}
