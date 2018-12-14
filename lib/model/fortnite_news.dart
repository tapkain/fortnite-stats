import 'package:intl/intl.dart';

class FortniteNewsArticle {
  final String title;
  final String body;
  final String image;
  final String time;

  String get timeFormatted {
    final timestamp = int.parse(time);
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  FortniteNewsArticle({this.title, this.body, this.image, this.time});

  factory FortniteNewsArticle.fromJson(Map<String, dynamic> json) {
    return FortniteNewsArticle(
      title: json['title'],
      body: json['body'],
      image: json['image'],
      time: json['time'],
    );
  }
}

class FortniteNews {
  final List<FortniteNewsArticle> news;

  FortniteNews({this.news});

  factory FortniteNews.fromJson(Map<String, dynamic> json) {
    final entries = json['entries'] as List;
    return FortniteNews(
      news: entries.map((i) => FortniteNewsArticle.fromJson(i)).toList(),
    );
  }
}
