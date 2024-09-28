class Movie {
  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.heroId,
  });

  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  String? heroId;

  List<String> get genres {
    return genreIds.map((id) => getGenreNameById(id)).toList();
  }

  String getGenreNameById(int id) {
    switch (id) {
      case 28:
        return 'Action';
      case 16:
        return 'Animation';
      case 35:
        return 'Comedy';
      case 18:
        return 'Drama';
      case 27:
        return 'Horror';
      default:
        return 'Others';
    }
  }

  get fullPosterImg {
    if (posterPath != null) {
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    }

    return 'https://xivahokimiyat.uz/templates/Reflex/dleimages/no_image.jpg';
  }

  get fullBackdropPath {
    if (backdropPath != null) {
      return 'https://image.tmdb.org/t/p/w500$backdropPath';
    }

    return 'https://xivahokimiyat.uz/templates/Reflex/dleimages/no_image.jpg';
  }

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "original_title": originalTitle,
        "poster_path_img": fullPosterImg,
        "backdrop_path_img": fullBackdropPath,
        "rating": voteAverage,
        "overview": overview,
      };
}
