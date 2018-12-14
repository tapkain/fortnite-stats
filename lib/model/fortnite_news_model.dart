import 'package:scoped_model/scoped_model.dart';
import 'package:fortnite_stats/util/api_client.dart';
import 'package:fortnite_stats/model/fortnite_news.dart';
import 'package:fortnite_stats/model/fortnite_user.dart';

enum FortniteNewsModelState { loading, loaded }

class FortniteNewsModel extends Model {
  final ApiClient apiClient;
  var state = FortniteNewsModelState.loading;
  var gameType = FortniteGameType.battleroyale;
  FortniteNews news;

  FortniteNewsModel({this.apiClient}) {
    retrieveNews();
  }

  void retrieveNews() async {
    state = FortniteNewsModelState.loading;
    notifyListeners();

    try {
      news = await apiClient.fetchGameNews(gameType);
      state = FortniteNewsModelState.loaded;
      notifyListeners();
    } catch (exception) {
//      state = PlayerDataModelState.empty;
//      onError();
//      notifyListeners();
    }
  }
}