import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/features/di/di_container.dart';
import 'package:movies_app/features/movie/domain/entities/movie.dart';

final movieProvider = FutureProvider<List<Movie>>((ref) async {
  final movieRepository = ref.read(movieRepositoryProvider);

  final List<Movie> movies = await movieRepository.getMovies();

  return movies;
});
