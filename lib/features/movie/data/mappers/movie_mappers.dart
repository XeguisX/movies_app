import 'package:movies_app/features/movie/data/models/movies_model.dart';
import 'package:movies_app/features/movie/domain/entities/movie.dart';

class MovieMapper {
  static List<Movie> toEntities(MoviesResponse moviesResponse) {
    return moviesResponse.results
        .map((movieResponse) => Movie(
              adult: movieResponse.adult,
              backdropPath: movieResponse.backdropPath,
              genreIds: movieResponse.genreIds,
              id: movieResponse.id,
              originalLanguage: movieResponse.originalLanguage,
              originalTitle: movieResponse.originalTitle,
              overview: movieResponse.overview,
              popularity: movieResponse.popularity,
              posterPath: movieResponse.posterPath,
              releaseDate: movieResponse.releaseDate,
              title: movieResponse.title,
              video: movieResponse.video,
              voteAverage: movieResponse.voteAverage,
              voteCount: movieResponse.voteCount,
            ))
        .toList();
  }
}

Movie moviefromJson(Map<String, dynamic> json) => Movie(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
      id: json["id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: json["popularity"].toDouble(),
      posterPath: json["poster_path"],
      releaseDate: json["release_date"],
      title: json["title"],
      video: json["video"],
      voteAverage: json["vote_average"].toDouble(),
      voteCount: json["vote_count"],
    );
