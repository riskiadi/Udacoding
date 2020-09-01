// To parse this JSON data, do
//
//     final movieModel = movieModelFromJson(jsonString);

import 'dart:convert';

MovieModel movieModelFromJson(String str) => MovieModel.fromJson(json.decode(str));

String movieModelToJson(MovieModel data) => json.encode(data.toJson());

class MovieModel {
  MovieModel({
    this.value,
    this.message,
    this.movies,
  });

  final int value;
  final String message;
  final List<Movie> movies;

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
    value: json["value"],
    message: json["message"],
    movies: List<Movie>.from(json["movies"].map((x) => Movie.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
    "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
  };
}

class Movie {
  Movie({
    this.id,
    this.movieName,
    this.thumbnail,
    this.description,
    this.link,
  });

  final String id;
  final String movieName;
  final String thumbnail;
  final String description;
  final String link;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json["id"],
    movieName: json["movie_name"],
    thumbnail: json["thumbnail"],
    description: json["description"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "movie_name": movieName,
    "thumbnail": thumbnail,
    "description": description,
    "link": link,
  };
}
