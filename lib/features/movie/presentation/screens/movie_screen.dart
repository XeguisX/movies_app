import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/features/movie/domain/entities/movie.dart';

import 'package:movies_app/features/movie/presentation/view_model/movie_provider.dart';
import 'package:movies_app/features/movie/presentation/widgets/movie_card.dart';
import 'package:movies_app/features/shared/widgets/widgets.dart';

class MovieScreen extends ConsumerStatefulWidget {
  const MovieScreen({super.key});

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    loadFilterSettings(ref);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movieAsyncValue = ref.watch(movieProvider);
    final categoryFilter = ref.watch(categoryFilterProvider);
    _searchController.text = ref.watch(nameFilterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: movieAsyncValue.when(
        data: (movies) {
          final uniqueGenres = _getUniqueGenres(movies);

          List<Movie> filteredMovies = movies.where((movie) {
            final matchesName = movie.title
                .toLowerCase()
                .contains(_searchController.text.toLowerCase());
            final matchesCategory = categoryFilter == 'All' ||
                movie.genres.contains(categoryFilter);
            return matchesName && matchesCategory;
          }).toList();

          return Column(
            children: [
              _buildFilters(ref, uniqueGenres),
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 350,
                      crossAxisCount: 2,
                    ),
                    itemCount: filteredMovies.length,
                    itemBuilder: (_, index) => MovieCard(
                      movie: filteredMovies[index],
                      heroId:
                          '${filteredMovies[index].title}-$index-${filteredMovies[index].id}',
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  List<String> _getUniqueGenres(List<Movie> movies) {
    final Set<String> genres = {};
    for (var movie in movies) {
      genres.addAll(movie.genres);
    }
    return genres.toList();
  }

  Widget _buildFilters(WidgetRef ref, List<String> uniqueGenres) {
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
            controller: _searchController,
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
