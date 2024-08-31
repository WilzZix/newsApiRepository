import 'package:hive/hive.dart';

part 'news_model.g.dart';

@HiveType(typeId: 0)
class News extends HiveObject {
  @HiveField(0)
  Source? source;
  @HiveField(1)
  String? author;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? url;
  @HiveField(5)
  String? urlToImage;
  @HiveField(6)
  String? publishedAt;
  @HiveField(7)
  String? content;

  News(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  static List<News> fetchData(Map<String, dynamic> json) {
    final List data = json['articles'] ?? [];
    final List<News> list = [];

    for (int i = 0; i < data.length; i++) {
      list.add(News.fromJson(data[i]));
    }

    return list;
  }

  News.fromJson(Map<String, dynamic> json) {
    source = json['source'] != null ? Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'] ?? '';
    url = json['url'] ?? '';
    urlToImage = json['urlToImage'] ??
        'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpotterhenry37.medium.com%2Fwhat-is-a-404-page-not-found-error-and-how-can-you-fix-it-a29ed9d6bc2a&psig=AOvVaw2e8GgTMLLnSqTom_xmreMS&ust=1720689551387000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCICj6J2SnIcDFQAAAAAdAAAAABAJ';
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (source != null) {
      data['source'] = source!.toJson();
    }
    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    return data;
  }
}

@HiveType(typeId: 1)
class Source extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
