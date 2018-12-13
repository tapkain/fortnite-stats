import 'package:flutter/material.dart';
import 'package:fortnite_stats/model/player_data_model.dart';
import 'package:fortnite_stats/model/fortnite_user.dart';
import 'package:fortnite_stats/model/player_data.dart';

class PlayerStatsQuery extends StatelessWidget {
  final PlayerDataModel _model;

  PlayerStatsQuery(this._model);

  static Widget queryButton(BuildContext context, String text, Color color,
      List<String> options, ValueChanged<String> onQuerySelected) {
    List<Widget> bottomSheetWidgets = [];
    bottomSheetWidgets.add(SizedBox(
      height: 30,
    ));
    bottomSheetWidgets.addAll(
      options.map((o) => FlatButton(
            child: Text(o),
            onPressed: () {
              onQuerySelected(o);
              Navigator.pop(context);
            },
          )),
    );
    bottomSheetWidgets.add(SizedBox(
      height: 30,
    ));

    return OutlineButton(
      child: Text(text),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: bottomSheetWidgets,
            );
          },
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      borderSide: BorderSide(color: color),
    );
  }

  Widget filterRow(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 8,
        ),
        PlayerStatsQuery.queryButton(
          context,
          _model.season.toUpperCase(),
          Colors.amber,
          FortniteSeason.values
              .map((s) => s.toString().split('.').last.toUpperCase())
              .toList(),
          (window) {
            _model.season = window;
            _model.update();
          },
        ),
        SizedBox(
          width: 8,
        ),
        PlayerStatsQuery.queryButton(
          context,
          _model.visibleStats.toString().split('.').last.toUpperCase(),
          Colors.redAccent,
          PlayerStatsType.values
              .map((s) => s.toString().split('.').last.toUpperCase())
              .toList(),
          (stat) {
            _model.updateVisibleStats(stat);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {},
                  ),
                  Text(
                    _model.playerData.username,
                    style: Theme.of(context).textTheme.display1,
                  ),
                ],
              ),
              filterRow(context),
            ],
          ),
        ),
      ),
    );
  }
}
