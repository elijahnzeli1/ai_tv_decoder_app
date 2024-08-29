import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ai_decoder_app/models/channel.dart';

class ApiService {
  final String baseUrl = 'https://api.tvmaze.com';

  Future<List<Channel>> fetchChannels() async {
    final response = await http.get(Uri.parse('$baseUrl/shows'));

    if (response.statusCode == 200) {
      List<dynamic> showsJson = json.decode(response.body);
      return showsJson.map((json) => Channel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load channels');
    }
  }

  Future<List<Channel>?> searchChannels(String query) async {
    final response =
        await http.get(Uri.parse('$baseUrl/search/shows?q=$query'));

    if (response.statusCode == 200) {
      List<dynamic> resultsJson = json.decode(response.body);
      List<Channel> channels = resultsJson
          .map<Channel>((json) => Channel.fromTVMazeJson(json))
          .toList();
      return channels;
    } else {
      throw Exception('Failed to search channels');
    }
  }
}
