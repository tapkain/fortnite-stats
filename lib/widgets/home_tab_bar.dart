import 'package:flutter/material.dart';
import 'package:fortnite_stats/widgets/player_stats/player_stats.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:fortnite_stats/model/player_data_model.dart';
import 'package:fortnite_stats/widgets/news/news.dart';
import 'package:fortnite_stats/util/api_client.dart';

class HomeTabBar extends StatelessWidget {
  final _apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.blue,
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.mail),
              title: new Text('Messages'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            )
          ],
        ),
        appBar: AppBar(title: Text('Flutter Fortnite')),
        body: TabBarView(
          children: <Widget>[
            NewsList(
              apiClient: _apiClient,
            ),
            Container(
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
