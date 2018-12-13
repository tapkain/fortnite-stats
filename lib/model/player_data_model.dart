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
  var platform = FortnitePlatform.pc.toString().split('.').last.toUpperCase();
  var season = FortniteSeason.alltime.toString().split('.').last;
  var visibleStats = PlayerStatsType.solo.toString().split('.').last;

  PlayerStats get stats => playerData.stats.playerStats[visibleStats];
  PlayerDataModelState state = PlayerDataModelState.empty;
  VoidCallback onError;

  void retrieveUser(String username) async {
    if (username.trim().length == 0) {
      return;
    }

    state = PlayerDataModelState.loading;
    notifyListeners();

    try {
      user = await _apiClient.fetchUser(username);
      update();
    } catch (exception) {
      state = PlayerDataModelState.empty;
      onError();
      notifyListeners();
    }
  }

  void _updatePlayerData(
      String platform, String season) async {
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

  void update() {
    _updatePlayerData(platform, season);
  }

  void updateVisibleStats(String stats) {
    visibleStats = stats.toLowerCase();
    notifyListeners();
  }

  void updatePlatform(String platform) {
    this.platform = platform;
    notifyListeners();
  }
}
