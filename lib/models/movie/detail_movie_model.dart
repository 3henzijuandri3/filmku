class DetailMovieModel {
  int? id;
  String? backdropPath;
  String? posterPath;
  String? tagline;
  String? title;
  double? voteAverage;
  String? releaseDate;
  int? runtime;
  Genres? genre;
  String? overview;

  DetailMovieModel({
    this.id,
    this.backdropPath,
    this.posterPath,
    this.tagline,
    this.title,
    this.voteAverage,
    this.releaseDate,
    this.runtime,
    this.genre,
    this.overview,
  });

  factory DetailMovieModel.fromJson(Map<String, dynamic> json) {
    return DetailMovieModel(
      id: json['id'],
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path'],
      tagline: json['tagline'],
      title: json['title'],
      voteAverage: json['vote_average']?.toDouble(),
      releaseDate: json['release_date'],
      runtime: json['runtime'],
      genre: json['genres'] != null
          ? Genres.fromJson(json['genres'][0])
          : null, // Take only the first genre
      overview: json['overview'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'backdrop_path': backdropPath,
      'poster_path': posterPath,
      'tagline': tagline,
      'title': title,
      'vote_average': voteAverage,
      'release_date': releaseDate,
      'runtime': runtime,
      'genre': genre?.toJson(), // Convert genre to json if not null
      'overview': overview,
    };
  }
}

class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
