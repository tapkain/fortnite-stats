import 'package:flutter/material.dart';
import 'package:fortnite_stats/widgets/news/news.dart';
import 'package:fortnite_stats/widgets/player_stats/player_stats.dart';
import 'package:fortnite_stats/util/api_client.dart';
import 'package:fortnite_stats/widgets/items/items.dart';

class HomeTabBar extends StatefulWidget {
  final _apiClient = ApiClient();

  @override
  State<StatefulWidget> createState() {
    return _HomeTabBarState(_apiClient);
  }
}

class _HomeTabBarState extends State<HomeTabBar> {
  final ApiClient _apiClient;
  var _currentIndex = 0;

  _HomeTabBarState(this._apiClient);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Fortnite'),
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.attachment),
              title: new Text('Stats'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.mail),
              title: new Text('News'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.access_alarm),
              title: new Text('Items'),
            ),
          ],
        ),
        body: currentPage(),
      ),
    );
  }

  Widget currentPage() {
    return [
      PlayerStatsView(
        apiClient: _apiClient,
      ),
      NewsList(
        apiClient: _apiClient,
      ),
      FortniteItemsList(
        apiClient: _apiClient,
      ),
    ][_currentIndex];
  }
}
