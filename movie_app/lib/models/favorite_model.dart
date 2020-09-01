// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'dart:convert';

FavoriteModel favoriteModelFromJson(String str) => FavoriteModel.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModel data) => json.encode(data.toJson());

class FavoriteModel {
  FavoriteModel({
    this.value,
    this.message,
    this.favorites,
  });

  final int value;
  final String message;
  final List<Favorite> favorites;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
    value: json["value"],
    message: json["message"],
    favorites: List<Favorite>.from(json["favorites"].map((x) => Favorite.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
    "favorites": List<dynamic>.from(favorites.map((x) => x.toJson())),
  };
}

class Favorite {
  Favorite({
    this.id,
    this.movieId,
    this.movieName,
    this.thumbnail,
    this.description,
    this.link,
  });

  final String id;
  final String movieId;
  final String movieName;
  final String thumbnail;
  final String description;
  final String link;

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    id: json["id"],
    movieId: json["movie_id"],
    movieName: json["movie_name"],
    thumbnail: json["thumbnail"],
    description: json["description"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "movie_id": movieId,
    "movie_name": movieName,
    "thumbnail": thumbnail,
    "description": description,
    "link": link,
  };
}
