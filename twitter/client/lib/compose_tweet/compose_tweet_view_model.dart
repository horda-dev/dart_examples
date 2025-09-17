import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_server/twitter_server.dart'; // For ClientCreateTweetRequested

class ComposeTweetViewModel {
  final BuildContext context;
  late final HordaClientSystem _hordaSystem;

  ComposeTweetViewModel(this.context) {
    _hordaSystem = HordaSystemProvider.of(context);
  }

  Future<void> sendTweet({required String text}) async {
    final result = await _hordaSystem.dispatchEvent(
      ClientCreateTweetRequested(
        authorUserId: context.hordaAuthUserId!,
        text: text,
        timelineIds: [],
      ),
    );

    if (result.isError) {
      throw Exception(result.value ?? 'Failed to send tweet.');
    }
  }
}
