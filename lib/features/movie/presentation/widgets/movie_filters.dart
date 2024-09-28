import 'package:easy_localization/easy_localization.dart';
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
          const SizedBox(height: 16),
          CustomTextField(
            labelText: 'search_by_name'.tr(),
            controller: searchController,
            onChanged: (value) {
              ref.read(nameFilterProvider.notifier).state = value;
              saveFilterSettings(ref);
            },
          ),
          const SizedBox(height: 16),
          CustomDropdown(
            labelText: 'select_genre'.tr(),
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
