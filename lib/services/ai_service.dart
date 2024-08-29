import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ai_decoder_app/models/channel.dart';

class AIService {
  final String apiKey = 'YOUR_AI_API_KEY'; // Replace with your actual API key
  final String aiApiUrl =
      'https://api.openai.com/v1/engines/davinci-codex/completions';

  Future<List<Channel>> getRecommendedChannels(
      List<Channel> channels, String userPreferences) async {
    final response = await http.post(
      Uri.parse(aiApiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'prompt':
            'Recommend TV channels based on these preferences: $userPreferences\nChannels: ${channels.map((c) => c.name).join(", ")}',
        'max_tokens': 100,
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final recommendations = result['choices'][0]['text'].split(',');
      return channels
          .where((channel) => recommendations.contains(channel.name.trim()))
          .toList();
    } else {
      throw Exception('Failed to get AI recommendations');
    }
  }

  Future<double> optimizeSignal(
      double currentFrequency, double signalStrength) async {
    final response = await http.post(
      Uri.parse(aiApiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'prompt':
            'Optimize TV signal: Current frequency $currentFrequency MHz, signal strength $signalStrength%. Suggest new frequency.',
        'max_tokens': 50,
        'temperature': 0.5,
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final suggestion = result['choices'][0]['text'];
      return double.parse(suggestion.replaceAll(RegExp(r'[^\d.]'), ''));
    } else {
      throw Exception('Failed to optimize signal');
    }
  }
}
