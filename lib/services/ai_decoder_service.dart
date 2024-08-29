import 'package:flutter/foundation.dart';
import 'package:ai_decoder_app/models/channel.dart';
import 'package:ai_decoder_app/services/api_service.dart';
import 'package:ai_decoder_app/utils/antenna_util.dart';
import 'package:flutter/material.dart';

class AiDecoderService with ChangeNotifier {
  List<Channel>? _channels = [];
  List<Channel>? get channels => _channels;

  List<Channel> get filteredChannels =>
      _channels
          ?.where((channel) =>
              selectedCategory == 'All' || channel.category == selectedCategory)
          .toList() ??
      [];

  String _selectedCategory = 'All';
  String get selectedCategory => _selectedCategory;

  bool _useEarphonesAsAntenna = false;
  bool get useEarphonesAsAntenna => _useEarphonesAsAntenna;

  String _selectedLanguage = 'English';
  String get selectedLanguage => _selectedLanguage;

  final ApiService _apiService = ApiService();
  final AntennaUtil _antennaUtil = AntennaUtil();

  List<String> get categories =>
      ['All', 'News', 'Sports', 'Entertainment', 'Education'];

  AiDecoderService() {
    _initChannels();
  }

  Future<void> _initChannels() async {
    _channels = await _apiService.fetchChannels();
    notifyListeners();
  }

  void searchChannels(String query) async {
    if (query.isEmpty) {
      await _initChannels();
    } else {
      _channels = await _apiService.searchChannels(query);
      notifyListeners();
    }
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void toggleEarphonesAsAntenna(BuildContext context) {
    _useEarphonesAsAntenna = !_useEarphonesAsAntenna;
    _antennaUtil.toggleEarphoneAntenna(context, _useEarphonesAsAntenna);
    notifyListeners();
  }

  void changeLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  void toggleFavorite(Channel channel) {
    final index = _channels?.indexWhere((c) => c.id == channel.id) ?? -1;
    if (index != -1) {
      if (_channels != null) {
        _channels![index].isFavorite = !_channels![index].isFavorite;
        notifyListeners();
      }
      notifyListeners();
    }
  }

  void clearFavorites() {
    if (_channels != null) {
      for (var channel in _channels!) {
        channel.isFavorite = false;
      }
    }
    notifyListeners();
  }

  Future<void> tuneChannel(BuildContext context, Channel channel) async {
    // Implement AI-powered signal optimization here
    await _antennaUtil.optimizeSignal(context, channel.frequency);
    // Additional logic for tuning the channel
  }
}
