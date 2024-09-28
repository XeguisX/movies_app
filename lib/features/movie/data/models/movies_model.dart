import 'package:movies_app/features/movie/data/mappers/movie_mappers.dart';
import 'package:movies_app/features/movie/domain/entities/movie.dart';

class MoviesResponse {
  MoviesResponse({
    required this.page,
    required this.results,
  });

  final int page;
  final List<Movie> results;

  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    return MoviesResponse(
      page: json["page"],
      results: List<Movie>.from(json["results"].map((x) => moviefromJson(x))),
    );
  }
}
