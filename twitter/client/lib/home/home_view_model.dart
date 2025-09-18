import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';

import '../queries.dart';
import '../shared/tweet_view_model.dart';

class HomeViewModel {
  final BuildContext context;
  final HordaClientSystem system;

  HomeViewModel(this.context) : system = HordaSystemProvider.of(context);

  EntityQueryDependencyBuilder<TimelineQuery> get timelineQuery {
    return context.query<UserTimelineQuery>().ref((q) => q.timeline);
  }

  int get tweetsLength {
    return timelineQuery.listLength((q) => q.tweets);
  }

  TweetViewModel getTweet(int index) {
    final tweetQuery = timelineQuery.listItem((q) => q.tweets, index);

    return TweetViewModel(context, tweetQuery);
  }
}
