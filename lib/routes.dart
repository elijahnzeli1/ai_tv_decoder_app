import 'package:flutter/material.dart';
import 'package:ai_decoder_app/screens/home_screen.dart';
import 'package:ai_decoder_app/screens/channel_list.dart';
import 'package:ai_decoder_app/screens/settings_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomeScreen(),
  '/channels': (context) => const ChannelListScreen(),
  '/settings': (context) => const SettingsScreen(),
};
