import 'package:flutter/material.dart';
import 'package:fortnite_stats/widgets/player_stats/player_stats_query.dart';
import 'package:fortnite_stats/model/player_data_model.dart';
import 'package:fortnite_stats/model/fortnite_user.dart';

class Search extends StatelessWidget {
  final ValueChanged<String> _onSearchUpdate;
  final PlayerDataModel _model;

  Search(this._onSearchUpdate, this._model);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: 'Search',
                    border: InputBorder.none),
                onSubmitted: (result) {
                  _onSearchUpdate(result);
                },
              ),
            ),
            PlayerStatsQuery.queryButton(
              context,
              _model.platform,
              Colors.red,
              FortnitePlatform.values
                  .map((p) => p.toString().split('.').last.toUpperCase())
                  .toList(),
              (platform) {
                _model.updatePlatform(platform);
              },
            )
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.black12),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16));
  }
}
