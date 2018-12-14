import 'package:flutter/material.dart';
import 'package:fortnite_stats/model/fortnite_news.dart';
import 'package:fortnite_stats/util/api_client.dart';
import 'package:fortnite_stats/model/fortnite_user.dart';
import 'article.dart';

class NewsList extends StatefulWidget {
  final ApiClient apiClient;

  NewsList({this.apiClient});

  @override
  _NewsListState createState() {
    return _NewsListState(apiClient);
  }
}

class _NewsListState extends State<NewsList>
    with SingleTickerProviderStateMixin {
  FortniteNews _news;
  final ApiClient _apiClient;
  var gameType = FortniteGameType.battleroyale;

  _NewsListState(this._apiClient);

  @override
  void initState() {
    _refreshFeed();
    super.initState();
  }

  Future<Null> _refreshFeed() {
    return _apiClient.fetchGameNews(gameType).then((news) {
      setState(() {
        _news = news;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_news == null) {
      return Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: _buildSwitcher(),
            ),
            Expanded(
              child: _buildNewsFeed(),
            )
          ],
        ),
      );
    }
  }

  Widget _buildSwitcherButton(String text, bool isSelected) {
    return OutlineButton(
      onPressed: () {
        if (isSelected) {
          return;
        }

        setState(() {
          gameType = gameType == FortniteGameType.battleroyale
              ? FortniteGameType.savetheworld
              : FortniteGameType.battleroyale;
          _refreshFeed();
        });
      },
      child: Text(text),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      borderSide:
          BorderSide(color: isSelected ? Colors.redAccent : Colors.white),
    );
  }

  Widget _buildSwitcher() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildSwitcherButton(
          'Battle Royale',
          gameType == FortniteGameType.battleroyale,
        ),
        SizedBox(
          width: 8,
        ),
        _buildSwitcherButton(
          'Save the World',
          gameType == FortniteGameType.savetheworld,
        ),
      ],
    );
  }

  Widget _buildNewsFeed() {
    return RefreshIndicator(
      onRefresh: () {
        return _refreshFeed();
      },
      child: ListView.builder(
        itemCount: _news.news.length,
        itemBuilder: (context, index) {
          final news = _news.news[index];
          return ArticleWidget(news: news);
        },
      ),
    );
  }
}
