class PosterTvModel {
  String? posterPath;
  int? id;
  String? originalName;
  double? voteAverage;

  PosterTvModel({
    this.posterPath,
    this.id,
    this.originalName,
    this.voteAverage,
  });

  factory PosterTvModel.fromJson(Map<String, dynamic> json) {
    return PosterTvModel(
      posterPath: json['poster_path'],
      id: json['id'],
      originalName: json['original_name'],
      voteAverage: json['vote_average']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'poster_path': posterPath,
      'id': id,
      'original_name': originalName,
      'vote_average': voteAverage,
    };
  }
}
