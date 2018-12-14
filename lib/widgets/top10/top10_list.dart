import 'package:flutter/material.dart';
import 'package:fortnite_stats/util/api_client.dart';
import 'package:fortnite_stats/model/fortnite_top10.dart';
import 'package:fortnite_stats/widgets/player_stats/player_stats_card.dart';
import 'package:tuple/tuple.dart';
import 'package:fortnite_stats/model/player_data.dart';
import 'package:fortnite_stats/widgets/player_stats/player_stats_query.dart';

class Top10List extends StatefulWidget {
  final ApiClient apiClient;

  Top10List({this.apiClient});

  @override
  _Top10ListState createState() {
    return _Top10ListState(apiClient: apiClient);
  }
}

class _Top10ListState extends State<Top10List> {
  final ApiClient apiClient;
  var top10query =
      FortniteTop10Queries.kills.toString().split('.').last.toUpperCase();
  List<Tuple2<PlayerStats, bool>> _topList;

  _Top10ListState({this.apiClient});

  @override
  void initState() {
    _refreshTop10();
    super.initState();
  }

  Future<Null> _refreshTop10() {
    return apiClient.fetchTop10(top10query).then((t) {
      setState(() {
        _topList = t.players.map((player) => Tuple2(player, false)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_topList == null) {
      return Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: CircularProgressIndicator(),
      );
    } else {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: PlayerStatsQuery.queryButton(
              context,
              'Top by $top10query',
              Colors.redAccent,
              FortniteTop10Queries.values
                  .map(
                    (v) => v.toString().split('.').last.toUpperCase(),
                  )
                  .toList(),
              (query) {
                setState(() {
                  top10query = query;
                  _topList = null;
                  _refreshTop10();
                });
              },
            ),
          ),
          Expanded(
            child: _buildBody(),
          ),
        ],
      );
    }
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () {
        return _refreshTop10();
      },
      child: ListView(
        children: <Widget>[
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                final tuple = _topList[index];
                _topList[index] = Tuple2(tuple.item1, !tuple.item2);
              });
            },
            children: _topList.map((tuple) {
              return _buildPanel(tuple);
            }).toList(),
          )
        ],
      ),
    );
  }

  ExpansionPanel _buildPanel(Tuple2<PlayerStats, bool> tuple) {
    final player = tuple.item1;
    return ExpansionPanel(
      isExpanded: tuple.item2,
      headerBuilder: (BuildContext context, bool isExpanded) {
        return _buildHeader(context, player);
      },
      body: PlayerStatsCard(
        player,
        renderAsCard: false,
      ),
    );
  }

  Widget _buildHeader(BuildContext context, PlayerStats player) {
    return Row(
      children: <Widget>[
        _iconForPlayer(context, player),
        Text(
          player.username ?? '???',
          style: Theme.of(context).textTheme.title,
        ),
      ],
    );
  }

  Widget _iconForPlayer(BuildContext context, PlayerStats player) {
    if (player.rank == 1) {
      return Image.asset(
        'assets/first_place.png',
        height: 40,
      );
    }

    if (player.rank == 2) {
      return Image.asset(
        'assets/second_place.png',
        height: 40,
      );
    }

    if (player.rank == 3) {
      return Image.asset(
        'assets/third_place.png',
        height: 40,
      );
    }

    return Container(
      width: 40,
      child: Text(
        player.rank.toString(),
        style: Theme.of(context).textTheme.headline,
        textAlign: TextAlign.center,
      ),
    );
  }
}
