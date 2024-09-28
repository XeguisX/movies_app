import 'package:movies_app/features/movie/data/datasources/movie_datasource_impl.dart';
import 'package:movies_app/features/movie/domain/datasources/movie_datasource.dart';
import 'package:movies_app/features/movie/domain/entities/movie.dart';
import 'package:movies_app/features/movie/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDatasource datasource;

  MovieRepositoryImpl({MovieDatasource? movieDatasource})
      : datasource = movieDatasource ?? MovieDatasourceImpl();

  @override
  Future<List<Movie>> getMovies() {
    return datasource.getMovies();
  }
}
