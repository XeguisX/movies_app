import 'package:movies_app/features/movie/domain/entities/movie.dart';
import 'package:movies_app/features/movie/domain/repositories/movie_repository.dart';

class FetchMovies {
  FetchMovies(this._movieRepository);

  final MovieRepository _movieRepository;

  Future<List<Movie>> call() async {
    try {
      final movies = await _movieRepository.fecthMovies();
      return movies;
    } catch (_) {
      rethrow;
    }
  }
}
