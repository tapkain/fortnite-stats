import 'package:flutter/material.dart';
import 'package:fortnite_stats/widgets/player_stats/player_stats_card.dart';
import 'package:fortnite_stats/widgets/player_stats/player_stats_query.dart';
import 'package:fortnite_stats/widgets/player_stats/search.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:fortnite_stats/model/player_data_model.dart';

class PlayerStatsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<PlayerDataModel>(
      builder: (context, child, model) {
        model.onError = () {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('We cannot find such user :(')),
          );
        };

        if (model.state == PlayerDataModelState.loaded) {
          return _buildPlayerDataWidget(context, model);
        } else {
          return _buildNoPlayerDataWidget(context, model);
        }
      },
    );
  }

  List<Widget> _buildNoPlayerBody() {
    return [
      Image.asset(
        'assets/anon.png',
        height: 150,
        fit: BoxFit.cover,
      ),
      Text('Anonymous? Try to search.'),
    ];
  }

  Widget _buildNoPlayerDataWidget(BuildContext context, PlayerDataModel model) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          _buildSearch(context, model),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: model.state == PlayerDataModelState.loading
                  ? [CircularProgressIndicator()]
                  : _buildNoPlayerBody(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPlayerDataWidget(BuildContext context, PlayerDataModel model) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        _buildSearch(context, model),
        SizedBox(
          height: 15,
        ),
        PlayerStatsQuery(model.playerData),
        SizedBox(
          height: 15,
        ),
        PlayerStatsCard(model.stats),
      ],
    );
  }

  Search _buildSearch(BuildContext context, PlayerDataModel model) {
    return Search((query) async {
      model.retrieveUser(query);
    });
  }
}