import 'package:flutter/material.dart';
import 'package:ai_decoder_app/services/ai_decoder_service.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final aiDecoderService = Provider.of<AiDecoderService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Use Earphones as Antenna'),
            value: aiDecoderService.useEarphonesAsAntenna,
            onChanged: (bool value) {
              aiDecoderService.toggleEarphonesAsAntenna(value as BuildContext);
            },
          ),
          ListTile(
            title: const Text('Language'),
            trailing: DropdownButton<String>(
              value: aiDecoderService.selectedLanguage,
              items: ['English', 'Spanish', 'French'].map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  aiDecoderService.changeLanguage(newValue);
                }
              },
            ),
          ),
          ListTile(
            title: const Text('Clear Favorites'),
            trailing: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                aiDecoderService.clearFavorites();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Favorites cleared')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
