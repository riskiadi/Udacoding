// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

List<PostModel> postModelFromJson(String str){
  return List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));
}

String postModelToJson(List<PostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel {
  PostModel({
    this.idNews,
    this.titleNews,
    this.contentNews,
  });

  final String idNews;
  final String titleNews;
  final String contentNews;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    idNews: json["id_news"],
    titleNews: json["title_news"],
    contentNews: json["content_news"],
  );

  Map<String, dynamic> toJson() => {
    "id_news": idNews,
    "title_news": titleNews,
    "content_news": contentNews,
  };
}
