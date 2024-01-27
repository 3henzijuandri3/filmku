class AccountStateModel {
  int? id;
  bool? favorite;
  bool? rated;
  bool? watchlist;

  AccountStateModel({this.id, this.favorite, this.rated, this.watchlist});

  factory AccountStateModel.fromJson(Map<String, dynamic> json) {
    return AccountStateModel(
      id: json['id'],
      favorite: json['favorite'],
      rated: json['rated'],
      watchlist: json['watchlist'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'favorite': favorite,
      'rated': rated,
      'watchlist': watchlist,
    };
    return data;
  }
}
