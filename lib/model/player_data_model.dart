import 'package:scoped_model/scoped_model.dart';
import 'player_data.dart';
import 'fortnite_user.dart';
import 'package:fortnite_stats/util/api_client.dart';
import 'package:flutter/material.dart';

enum PlayerDataModelState { empty, loading, loaded }

class PlayerDataModel extends Model {
  final _apiClient = ApiClient();
  FortniteUser user;
  PlayerData playerData;
  var visibleStats = PlayerStatsType.solo;

  PlayerStats get stats => playerData.stats.playerStats[visibleStats];
  PlayerDataModelState state = PlayerDataModelState.empty;
  VoidCallback onError;

  void retrieveUser(String username) async {
    state = PlayerDataModelState.loading;
    notifyListeners();

    try {
      user = await _apiClient.fetchUser(username);
      updatePlayerData(FortnitePlatform.pc, FortniteSeason.alltime);
    } catch (exception) {
      state = PlayerDataModelState.empty;
      onError();
      notifyListeners();
    }
  }

  void updatePlayerData(
      FortnitePlatform platform, FortniteSeason season) async {
    if (state != PlayerDataModelState.loading) {
      state = PlayerDataModelState.loading;
      notifyListeners();
    }

    try {
      playerData = await _apiClient.fetchPlayerData(user, platform, season);
      state = PlayerDataModelState.loaded;
      notifyListeners();
    } catch (exception) {
      state = PlayerDataModelState.empty;
      onError();
      notifyListeners();
    }
  }
}
