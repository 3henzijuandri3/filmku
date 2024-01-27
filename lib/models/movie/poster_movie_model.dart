class PosterMovieModel {
  String? posterPath;
  int? id;
  String? originalTitle;
  double? voteAverage;

  PosterMovieModel({
    this.posterPath,
    this.id,
    this.originalTitle,
    this.voteAverage,
  });

  factory PosterMovieModel.fromJson(Map<String, dynamic> json) {
    return PosterMovieModel(
      posterPath: json['poster_path'],
      id: json['id'],
      originalTitle: json['original_title'],
      voteAverage: json['vote_average']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'poster_path': posterPath,
      'id': id,
      'original_title': originalTitle,
      'vote_average': voteAverage,
    };
  }
}
