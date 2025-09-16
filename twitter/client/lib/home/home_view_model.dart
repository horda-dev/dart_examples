import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';

import '../queries.dart';
import 'home_models.dart';

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

  TweetItem getTweet(int index) {
    final tweetQuery = timelineQuery.listItem((q) => q.tweets, index);
    final authorQuery = tweetQuery.ref((q) => q.authorUser);

    return TweetItem(
      id: tweetQuery.id(),
      author: TweetAuthorItem(
        id: authorQuery.id(),
        handle: authorQuery.value((q) => q.handle),
        displayName: authorQuery
            .ref((q) => q.profile)
            .value((q) => q.displayName),
      ),
      text: tweetQuery.value((q) => q.text),
      createdAt: tweetQuery.value((q) => q.createdAt),
      likeCount: tweetQuery.counter((q) => q.likeCount),
      retweetCount: tweetQuery.counter((q) => q.retweetCount),
    );
  }
}
