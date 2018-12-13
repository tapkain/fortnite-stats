import 'package:fortnite_stats/util/api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fortnite_stats/model/fortnite_user.dart';
import 'package:fortnite_stats/model/player_data.dart';

void main() {
  final client = ApiClient();
  const username = 'Ninja';
  FortniteUser user;

  group('Api Client', () {
    test('should fetch user model', () async {
      user = await client.fetchUser(username);
      expect(user.uid, '4735ce9132924caf8a5b17789b40f79c');
      expect(user.username, username);
    });

    test('should fetch player data', () async {
      final playerData = await client.fetchPlayerData(user, 'pc', 'alltime');
      expect(playerData.username, username);
      expect(playerData.platform, 'pc');
      expect(playerData.window, 'alltime');

      final soloStats = playerData.stats.playerStats[PlayerStatsType.solo];
      final placetop = soloStats.placetop.firstWhere((element) {
        return element.item1 == 1;
      }).item2;
      expect(placetop.runtimeType, 0.runtimeType);
    });
  });
}
