class RandomMovieModel {
  String? backdropPath;
  int? id;
  String? originalTitle;
  String? releaseDate;
  String? originalLanguage;
  double? voteAverage;

  RandomMovieModel({
    this.backdropPath,
    this.id,
    this.originalTitle,
    this.releaseDate,
    this.voteAverage,
    this.originalLanguage
  });

  factory RandomMovieModel.fromJson(Map<String, dynamic> json) {
    return RandomMovieModel(
      backdropPath: json['backdrop_path'],
      id: json['id'],
      originalTitle: json['original_title'],
      releaseDate: json['release_date'],
      originalLanguage: json['original_language'],
      voteAverage: json['vote_average']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'backdrop_path': backdropPath,
      'id': id,
      'original_title': originalTitle,
      'release_date': releaseDate,
      'original_language' : originalLanguage,
      'vote_average': voteAverage,
    };
  }
}
