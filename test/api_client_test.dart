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
      final playerData = await client.fetchPlayerData(
          user, FortnitePlatform.pc, FortniteSeason.alltime
      );
      expect(playerData.username, username);
      expect(playerData.platform, 'pc');
      expect(playerData.window, 'alltime');
      expect(playerData.totals.kills, 92040);
      expect(playerData.totals.wins, 4815);
      expect(playerData.totals.hoursplayed, 835);
      expect(playerData.totals.kd, 11.11);

      final soloStats = playerData.stats.playerStats[PlayerStatsType.solo];
      print(soloStats);
      expect(soloStats.winrate, 34.75);
      expect(soloStats.score, 1719223);

      final placetop = soloStats.placetop.firstWhere((element) {
        return element.item1 == 1;
      }).item2;
      expect(placetop, 1797);
    });
  });
}