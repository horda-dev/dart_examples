import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_client/queries.dart';
import 'home_models.dart'; // Import the new models

class HomeViewModel {
  final BuildContext context;
  late final HordaClientSystem _hordaSystem;
  late final EntityQueryDependencyBuilder<UserAccountQuery> _userAccountQuery;

  HomeViewModel(this.context) {
    _hordaSystem = HordaSystemProvider.of(context);
    _userAccountQuery = context.query<UserAccountQuery>(); // Get the query here
  }

  // Getters for UserAccount details
  String get handle => _userAccountQuery.value((q) => q.handle);
  String get email => _userAccountQuery.value((q) => q.email);
  int get followerCount => _userAccountQuery.counter((q) => q.followerCount);
  int get followingCount => _userAccountQuery.counter((q) => q.followingCount);
  DateTime get registeredAt => _userAccountQuery.value((q) => q.registeredAt);

  UserProfileItem get profile {
    final profileQuery = _userAccountQuery.ref((q) => q.profile);
    return UserProfileItem(
      id: profileQuery.id(), // Assuming profileQuery has an ID
      displayName: profileQuery.value((q) => q.displayName),
      bio: profileQuery.value((q) => q.bio),
    );
  }

  // Getters for Timeline
  int get tweetsLength {
    final timelineQuery = _userAccountQuery.ref((q) => q.timeline);
    return timelineQuery.listLength((q) => q.tweets);
  }

  TweetItem getTweet(int index) {
    final timelineQuery = _userAccountQuery.ref((q) => q.timeline);
    final tweetQuery = timelineQuery.listItem((q) => q.tweets, index);

    final authorAccountQuery = tweetQuery.ref((q) => q.authorUser);
    final authorProfileQuery = authorAccountQuery.ref((q) => q.profile); // Access profile through UserAccount
    final authorAccountItem = UserAccountItem(
      id: _userAccountQuery.id(),
      handle: authorAccountQuery.value((q) => q.handle),
      email: authorAccountQuery.value((q) => q.email),
      profile: UserProfileItem(
        id: authorProfileQuery.id(),
        displayName: authorProfileQuery.value((q) => q.displayName),
        bio: authorProfileQuery.value((q) => q.bio),
      ),
      followerCount: authorAccountQuery.counter((q) => q.followerCount),
      followingCount: authorAccountQuery.counter((q) => q.followingCount),
      registeredAt: authorAccountQuery.value((q) => q.registeredAt),
    );

    return TweetItem(
      id: tweetQuery.id(),
      author: authorAccountItem,
      text: tweetQuery.value((q) => q.text),
      createdAt: tweetQuery.value((q) => q.createdAt),
      likeCount: tweetQuery.counter((q) => q.likeCount),
      retweetCount: tweetQuery.counter((q) => q.retweetCount),
    );
  }
}