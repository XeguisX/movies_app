import 'package:movies_app/features/movie/domain/entities/movie.dart';

abstract class MovieDatasource {
  Future<List<Movie>> getMovies();
}
