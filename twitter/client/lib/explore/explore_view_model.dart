import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';

import '../queries.dart';
import '../shared/tweet_view_model.dart';

class ExploreViewModel {
  final BuildContext context;
  final HordaClientSystem system;

  ExploreViewModel(this.context) : system = HordaSystemProvider.of(context);

  int get tweetsLength {
    return context.query<ExploreFeedQuery>().listLength((q) => q.tweets);
  }

  TweetViewModel getTweet(int index) {
    final tweetQuery = context.query<ExploreFeedQuery>().listItem(
      (q) => q.tweets,
      index,
    );

    return TweetViewModel(tweetQuery);
  }
}
