import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_server/twitter_server.dart';

import '../queries.dart';

class ComposeTweetViewModel {
  final BuildContext context;
  late final HordaClientSystem _hordaSystem;

  ComposeTweetViewModel(this.context) {
    _hordaSystem = HordaSystemProvider.of(context);
  }

  Future<String> sendTweet({
    required String text,
    String? attachmentBase64,
  }) async {
    final myTimelineId = context.query<MeQuery>().refId((q) => q.timeline);

    final followerCount = context.query<MeQuery>().listLength(
      (q) => q.followers,
    );

    final followerTimelineIds = <String>[
      for (var i = 0; i < followerCount; i++)
        context
            .query<MeQuery>()
            .listItem((q) => q.followers, i)
            .refId((q) => q.timeline),
    ];

    final result = await _hordaSystem.dispatchEvent(
      ClientCreateTweetRequested(
        authorUserId: context.hordaAuthUserId!,
        text: text,
        attachmentBase64: attachmentBase64,
        timelineIds: [
          myTimelineId,
          ...followerTimelineIds,
        ],
      ),
    );

    if (result.isError) {
      throw Exception(result.value ?? 'Failed to send tweet.');
    }

    return result.value!;
  }
}
