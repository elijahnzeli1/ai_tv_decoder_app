import 'package:flutter/material.dart';
import 'package:ai_decoder_app/widgets/channel_card.dart';
import 'package:ai_decoder_app/services/ai_decoder_service.dart';
import 'package:provider/provider.dart';

class ChannelListScreen extends StatelessWidget {
  const ChannelListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final aiDecoderService = Provider.of<AiDecoderService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Channels'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: aiDecoderService.selectedCategory,
              items: aiDecoderService.categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  aiDecoderService.selectCategory(newValue);
                }
              },
            ),
          ),
          Expanded(
            child: Consumer<AiDecoderService>(
              builder: (context, service, child) {
                return ListView.builder(
                  itemCount: service.filteredChannels.length,
                  itemBuilder: (context, index) {
                    return ChannelCard(
                        channel: service.filteredChannels[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
