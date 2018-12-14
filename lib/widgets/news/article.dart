import 'package:flutter/material.dart';
import 'package:fortnite_stats/model/fortnite_news.dart';

class ArticleWidget extends StatelessWidget {
  FortniteNewsArticle news;

  ArticleWidget({this.news});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          Image.network(news.image),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Text(
                  news.title,
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  news.body,
                  style: Theme.of(context).textTheme.body1,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                news.timeFormatted,
                style: Theme.of(context).textTheme.subtitle.apply(color: Colors.grey),
              ),
              SizedBox(width: 16,)
            ],
          ),
          SizedBox(height: 16,)
        ],
      ),
    );
  }
}