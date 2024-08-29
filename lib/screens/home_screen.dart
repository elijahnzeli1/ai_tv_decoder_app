import 'package:flutter/material.dart';
import 'package:ai_decoder_app/widgets/channel_card.dart';
import 'package:ai_decoder_app/services/ai_decoder_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final aiDecoderService = Provider.of<AiDecoderService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI TV Decoder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search channels globally',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => aiDecoderService.searchChannels(value),
            ),
          ),
          Expanded(
            child: Consumer<AiDecoderService>(
              builder: (context, service, child) {
                if (service.channels?.isEmpty ?? true) {
                  return const Center(child: Text('No channels found'));
                }
                return ListView.builder(
                  itemCount: service.channels?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ChannelCard(channel: service.channels![index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.list),
        onPressed: () => Navigator.pushNamed(context, '/channels'),
      ),
    );
  }
}
