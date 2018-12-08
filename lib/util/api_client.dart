import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fortnite_stats/model/fortnite_user.dart';

class ApiClient {
  static final _client = ApiClient._internal();
  final String _baseUrl = 'https://fortnite-public-api.theapinetwork.com/prod09/';

  ApiClient._internal();
  factory ApiClient() => _client;

  Future<FortniteUser> fetchUserId(String username) async {
    final response = await http.get(_baseUrl + 'users/id');

    if (response.statusCode == 200) {
      return FortniteUser.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch user $username');
    }
  }
}