import 'dart:convert';

HomePageNewsModel homePageNewsModelFromJson(String str) =>
    HomePageNewsModel.fromJson(json.decode(str));

String homePageNewsModelToJson(HomePageNewsModel data) =>
    json.encode(data.toJson());

class HomePageNewsModel {
  HomePageNewsModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  String? status;
  int? totalResults;
  List<Article>? articles;

  factory HomePageNewsModel.fromJson(Map<String, dynamic> json) =>
      HomePageNewsModel(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles!.map((x) => x.toJson())),
      };
}

class Article {
  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source!.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt!.toIso8601String(),
        "content": content,
      };
  static Map<String, dynamic> toMap(Article articleslists) => {
        'source': articleslists.source,
        'author': articleslists.author,
        'title': articleslists.title,
        'description': articleslists.description,
        "url": articleslists.url,
        'urlToImage': articleslists.urlToImage,
        "publishedAt": articleslists.publishedAt!.toIso8601String(),
        "content": articleslists.content,
      };

  static String encode(List<Article> articleslists) => json.encode(
        articleslists
            .map<Map<String, dynamic>>(
                (articleslists) => Article.toMap(articleslists))
            .toList(),
      );

  static List<Article> decode(String articleslists) =>
      (json.decode(articleslists) as List<dynamic>)
          .map<Article>((item) => Article.fromJson(item))
          .toList();
}

class Source {
  Source({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
  static Map<String, dynamic> toMap(Source sourcelists) => {
        'id': sourcelists.id,
        'name': sourcelists.id,
      };

  static String encode(List<Source> articleslists) => json.encode(
        articleslists
            .map<Map<String, dynamic>>(
                (articleslists) => Source.toMap(articleslists))
            .toList(),
      );

  static List<Source> decode(String articleslists) =>
      (json.decode(articleslists) as List<dynamic>)
          .map<Source>((item) => Source.fromJson(item))
          .toList();
}
