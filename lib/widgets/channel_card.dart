import 'package:flutter/material.dart';
import 'package:ai_decoder_app/models/channel.dart';
import 'package:ai_decoder_app/services/ai_decoder_service.dart';
import 'package:provider/provider.dart';

class ChannelCard extends StatelessWidget {
  final Channel channel;

  const ChannelCard({Key? key, required this.channel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final aiDecoderService = Provider.of<AiDecoderService>(context);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: const Icon(Icons.tv),
        title: Text(channel.name),
        subtitle: Text('${channel.category} | ${channel.region}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                channel.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: channel.isFavorite ? Colors.red : null,
              ),
              onPressed: () => aiDecoderService.toggleFavorite(channel),
            ),
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: () => aiDecoderService.tuneChannel(context, channel),
            ),
          ],
        ),
        onTap: () => aiDecoderService.tuneChannel(context, channel),
      ),
    );
  }
}
