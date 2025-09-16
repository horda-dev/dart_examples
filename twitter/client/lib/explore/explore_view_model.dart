import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_client/queries.dart';
import '../home/home_models.dart'; // For TweetItem, UserProfileItem

class ExploreViewModel {
  final BuildContext context;
  late final HordaClientSystem _hordaSystem;
  late final EntityQueryDependencyBuilder<ExploreFeedQuery> _exploreFeedQuery;

  ExploreViewModel(this.context) {
    _hordaSystem = HordaSystemProvider.of(context);
    _exploreFeedQuery = context.query<ExploreFeedQuery>(); // Get the query for the explore feed
  }

  // Getters for Explore Feed Tweets
  int get tweetsLength {
    return _exploreFeedQuery.listLength((q) => q.tweets);
  }

  TweetItem getTweet(int index) {
    final tweetQuery = _exploreFeedQuery.listItem((q) => q.tweets, index);

    final authorProfileQuery = tweetQuery.ref((q) => q.authorUser);
    final authorProfileItem = UserProfileItem(
      displayName: authorProfileQuery.value((q) => q.displayName),
      bio: authorProfileQuery.value((q) => q.bio),
      followerCount: authorProfileQuery.counter((q) => q.followerCount),
      followingCount: authorProfileQuery.counter((q) => q.followingCount),
    );

    return TweetItem(
      id: tweetQuery.id(),
      author: authorProfileItem,
      text: tweetQuery.value((q) => q.text),
      createdAt: tweetQuery.value((q) => q.createdAt),
      likeCount: tweetQuery.counter((q) => q.likeCount),
      retweetCount: tweetQuery.counter((q) => q.retweetCount),
    );
  }
}
