import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/features/movie/domain/entities/movie.dart';
import 'package:movies_app/features/movie/domain/repositories/movie_repository.dart';
import 'package:movies_app/features/movie/domain/use_cases/fetch_movies.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  group('Fetch Movies', () {
    late MovieRepository mockMovieRepository;

    setUp(() {
      mockMovieRepository = MockMovieRepository();
    });

    test('when fetch then is success', () async {
      // Arrange
      when(mockMovieRepository.fecthMovies).thenAnswer((_) async => []);
      final fetchMovies = FetchMovies(mockMovieRepository);

      // Action
      final result = await fetchMovies();

      // Assert
      expect(result, isA<List<Movie>>());
    });

    test('when fetch then is failure', () async {
      // Arrange
      when(mockMovieRepository.fecthMovies).thenThrow(Exception());
      final fetchMovies = FetchMovies(mockMovieRepository);

      // Action
      expect(() async => await fetchMovies(), throwsA(isA<Exception>()));
    });
  });
}
