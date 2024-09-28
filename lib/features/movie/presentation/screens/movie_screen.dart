import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movies_app/features/movie/domain/entities/movie.dart';
import 'package:movies_app/features/movie/presentation/provider/providers.dart';
import 'package:movies_app/features/movie/presentation/widgets/movie_card.dart';
import 'package:movies_app/features/movie/presentation/widgets/movie_filters.dart';
import 'package:movies_app/shared/widgets/widgets.dart';

class MovieScreen extends ConsumerStatefulWidget {
  const MovieScreen({super.key});

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  late TextEditingController _searchController;

  List<String> _getUniqueGenres(List<Movie> movies) {
    final Set<String> genres = {};
    for (var movie in movies) {
      genres.addAll(movie.genres);
    }
    return genres.toList();
  }

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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.movie_filter,
                color: Colors.black,
              ),
              const SizedBox(width: 10),
              Text(
                'movies'.tr(),
                style: const TextStyle(
                  fontSize: 24,
                  letterSpacing: 1.2,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: movieAsyncValue.when(
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
                  MovieFilters(
                    uniqueGenres: uniqueGenres,
                    searchController: _searchController,
                  ),
                  (filteredMovies.isEmpty)
                      ? const Center(
                          child: Image(image: AssetImage('assets/no-data.png')),
                        )
                      : Expanded(
                          child: Scrollbar(
                            thumbVisibility: true,
                            child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
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
            error: (err, stack) => const CustomErrorWidget(),
          ),
        ),
      ),
    );
  }
}
