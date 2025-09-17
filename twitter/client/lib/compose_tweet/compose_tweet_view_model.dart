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
    // This is a placeholder, actual implementation needs current user ID.
    final authorUserId = _hordaSystem.authState.value is AuthStateLoggedIn
        ? (_hordaSystem.authState.value as AuthStateLoggedIn).userId
        : 'dummy-user-id';

    final result = await _hordaSystem.dispatchEvent(
      ClientCreateTweetRequested(
        authorUserId: authorUserId,
        text: text,
      ),
    );

    if (result.isError) {
      throw Exception(result.value ?? 'Failed to send tweet.');
    }
  }
}
