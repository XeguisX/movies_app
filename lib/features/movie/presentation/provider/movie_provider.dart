import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/di/di_container.dart';
import 'package:movies_app/features/movie/domain/entities/movie.dart';
import 'package:movies_app/features/movie/domain/use_cases/fetch_movies.dart';

final movieProvider = FutureProvider<List<Movie>>((ref) async {
  final movieRepository = ref.read(movieRepositoryProvider);
  final fetchUniversities = FetchMovies(movieRepository);
  final List<Movie> movies = await fetchUniversities();

  return movies;
});
