import 'package:flutter/material.dart';
import 'package:fortnite_stats/widgets/news/news.dart';
import 'package:fortnite_stats/widgets/player_stats/player_stats.dart';
import 'package:fortnite_stats/util/api_client.dart';
import 'package:fortnite_stats/widgets/items/items.dart';
import 'package:fortnite_stats/widgets/top10/top10_list.dart';

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
      length: 4,
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
              icon: Icon(Icons.attachment),
              title: Text('Stats'),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              title: Text('News'),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm),
              title: Text('Items'),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text('Top 10'),
              backgroundColor: Theme.of(context).primaryColor,
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
      Top10List(
        apiClient: _apiClient,
      ),
    ][_currentIndex];
  }
}
