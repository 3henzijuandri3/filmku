class TvDetailModel {
  int? id;
  String? backdropPath;
  String? posterPath;
  String? tagline;
  String? name;
  double? voteAverage;
  String? firstAirDate;
  List<int>? episodeRunTime;
  Genres? genre;
  String? overview;
  int? numberOfSeasons;
  int? numberOfEpisodes;

  TvDetailModel({
    this.id,
    this.backdropPath,
    this.posterPath,
    this.tagline,
    this.name,
    this.voteAverage,
    this.firstAirDate,
    this.episodeRunTime,
    this.genre,
    this.overview,
    this.numberOfSeasons,
    this.numberOfEpisodes,
  });

  factory TvDetailModel.fromJson(Map<String, dynamic> json) {
    return TvDetailModel(
      id: json['id'],
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path'],
      tagline: json['tagline'],
      name: json['name'],
      voteAverage: json['vote_average']?.toDouble(),
      firstAirDate: json['first_air_date'],
      episodeRunTime: json['episode_run_time']?.cast<int>(),
      genre: json['genres'] != null && json['genres'].isNotEmpty ? Genres.fromJson(json['genres'][0]) : null,
      overview: json['overview'],
      numberOfSeasons: json['number_of_seasons'],
      numberOfEpisodes: json['number_of_episodes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'backdrop_path': backdropPath,
      'poster_path': posterPath,
      'tagline': tagline,
      'name': name,
      'vote_average': voteAverage,
      'first_air_date': firstAirDate,
      'episode_run_time': episodeRunTime,
      'genres': genre?.toJson(),
      'overview': overview,
      'number_of_seasons': numberOfSeasons,
      'number_of_episodes': numberOfEpisodes,
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
