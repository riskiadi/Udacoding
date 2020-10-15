// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

List<NewsModel> newsModelFromJson(String str) => List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));

String newsModelToJson(List<NewsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModel {

  final int newsId;
  final String newsTitle;
  final String newsContent;
  final String newsBanner;
  final NewsCategory newsCategory;
  final NewsAuthor newsAuthor;

  NewsModel({
    this.newsId,
    this.newsTitle,
    this.newsContent,
    this.newsBanner,
    this.newsCategory,
    this.newsAuthor,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    newsId: json["news_id"],
    newsTitle: json["news_title"],
    newsContent: json["news_content"],
    newsBanner: json["news_banner"],
    newsCategory: NewsCategory.fromJson(json["news_category"]),
    newsAuthor: NewsAuthor.fromJson(json["news_author"]),
  );

  Map<String, dynamic> toJson() => {
    "news_id": newsId,
    "news_title": newsTitle,
    "news_content": newsContent,
    "news_banner": newsBanner,
    "news_category": newsCategory.toJson(),
    "news_author": newsAuthor.toJson(),
  };
}

class NewsAuthor {

  final int authorId;
  final String authorName;
  final String authorEmail;

  NewsAuthor({
    this.authorId,
    this.authorName,
    this.authorEmail,
  });

  factory NewsAuthor.fromJson(Map<String, dynamic> json) => NewsAuthor(
    authorId: json["author_id"],
    authorName: json["author_name"],
    authorEmail: json["author_email"],
  );

  Map<String, dynamic> toJson() => {
    "author_id": authorId,
    "author_name": authorName,
    "author_email": authorEmail,
  };
}

class NewsCategory {

  final int categoryId;
  final String categoryName;

  NewsCategory({
    this.categoryId,
    this.categoryName,
  });

  factory NewsCategory.fromJson(Map<String, dynamic> json) => NewsCategory(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
  };
}
