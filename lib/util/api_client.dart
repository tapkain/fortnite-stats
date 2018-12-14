import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:fortnite_stats/model/fortnite_user.dart';
import 'package:fortnite_stats/model/player_data.dart';
import 'package:fortnite_stats/model/fortnite_news.dart';
import 'package:fortnite_stats/model/fortnite_items.dart';
import 'package:fortnite_stats/model/fortnite_top10.dart';

class _FortniteHttpClient extends http.BaseClient {
  final String _baseUrl = 'https://fortnite-public-api.theapinetwork.com/prod09/';
  final String _apiKey = <API KEY>;
  final http.Client _inner;

  _FortniteHttpClient(this._inner);

  void _log(http.BaseRequest r) {
    final request = r as http.Request;
    print('${request.method} ${request.url.toString()}');
    print(request.body);
    request.headers.forEach((key, value) {
      print('$key: $value');
    });
  }

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers[HttpHeaders.authorizationHeader] = _apiKey;
    _log(request);
    return _inner.send(request);
  }

  Future<Map<String, dynamic>> apiGet(String query, Map<String, String> body) async {
    final request = http.Request('POST', Uri.parse(_baseUrl + query));
    request.bodyFields = body;
    final response = await send(request);

    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      return json.decode(body);
    } else {
      throw Exception('Invalid status code - ${response.statusCode}');
    }
  }
}

class ApiClient {
  static final _apiClient = ApiClient._internal();
  final _client = _FortniteHttpClient(http.Client());

  ApiClient._internal();
  factory ApiClient() => _apiClient;

  Future<FortniteUser> fetchUser(String username) async {
    final json = await _client.apiGet('users/id', {'username': username});
    return FortniteUser.fromJson(json);
  }

  Future<PlayerData> fetchPlayerData(
      FortniteUser user,
      String platform,
      String season) async {
    final json = await _client.apiGet('users/public/br_stats', {
      'user_id': user.uid,
      'platform': platform.toLowerCase(),
      'window': season.toLowerCase()
    });
    return PlayerData.fromJson(json);
  }

  Future<FortniteNews> fetchGameNews(FortniteGameType gameType) async {
    final url = gameType == FortniteGameType.savetheworld ? 'stw_motd/get' : 'br_motd/get';
    // TODO: Add support for multiple languages
    final json = await _client.apiGet(url, {'language': 'en'});
    return FortniteNews.fromJson(json);
  }

  Future<FortniteItems> fetchStoreItems(FortniteItemsQuery itemsQuery) async {
    final url = itemsQuery == FortniteItemsQuery.current ? 'store/get' : 'upcoming/get';
    final json = await _client.apiGet(url, {'language': 'en'});
    return FortniteItems.fromJson(json);
  }

  Future<FortniteTop10> fetchTop10(String query) async {
    final window = 'top_10_${query.toLowerCase()}';
    final json = await _client.apiGet('leaderboards/get', {'window': window});
    return FortniteTop10.fromJson(json);
  }
}