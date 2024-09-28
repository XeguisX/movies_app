import 'package:movies_app/features/movie/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getMovies();
}
