class UserProfileModel {
  Avatar? avatar;
  int? id;
  String? name;
  bool? includeAdult;
  String? username;

  UserProfileModel({
    this.avatar,
    this.id,
    this.name,
    this.includeAdult,
    this.username,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      avatar: json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null,
      id: json['id'],
      name: json['name'],
      includeAdult: json['include_adult'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'include_adult': includeAdult,
      'username': username,
    };
    if (avatar != null) {
      data['avatar'] = avatar!.toJson();
    }
    return data;
  }
}

class Avatar {
  Gravatar? gravatar;
  Tmdb? tmdb;

  Avatar({this.gravatar, this.tmdb});

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      gravatar: json['gravatar'] != null ? Gravatar.fromJson(json['gravatar']) : null,
      tmdb: json['tmdb'] != null ? Tmdb.fromJson(json['tmdb']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (gravatar != null) {
      data['gravatar'] = gravatar!.toJson();
    }
    if (tmdb != null) {
      data['tmdb'] = tmdb!.toJson();
    }
    return data;
  }
}

class Gravatar {
  String? hash;

  Gravatar({this.hash});

  factory Gravatar.fromJson(Map<String, dynamic> json) {
    return Gravatar(
      hash: json['hash'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'hash': hash};
  }
}

class Tmdb {
  String? avatarPath;

  Tmdb({this.avatarPath});

  factory Tmdb.fromJson(Map<String, dynamic> json) {
    return Tmdb(
      avatarPath: json['avatar_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'avatar_path': avatarPath};
  }
}
