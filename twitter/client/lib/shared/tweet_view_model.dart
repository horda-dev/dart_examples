import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_server/twitter_server.dart';

import '../queries.dart';
import 'author_user_view_model.dart';

class TweetViewModel {
  final BuildContext context;
  final EntityQueryDependencyBuilder<TweetQuery> tweetQuery;

  TweetViewModel(this.context, this.tweetQuery);

  String get id {
    return tweetQuery.id();
  }

  AuthorUserViewModel get author {
    return AuthorUserViewModel(
      tweetQuery.ref((q) => q.authorUser),
    );
  }

  String get text {
    return tweetQuery.value((q) => q.text);
  }

  DateTime get createdAt {
    return tweetQuery.value((q) => q.createdAt);
  }

  int get likeCount {
    return tweetQuery.counter((q) => q.likeCount);
  }

  int get retweetCount {
    return tweetQuery.counter((q) => q.retweetCount);
  }

  int get commentCount {
    return tweetQuery.counter((q) => q.commentCount);
  }

  bool get isLikedByCurrentUser {
    final currentUserId = context.hordaAuthUserId;
    if (currentUserId == null) return false;
    return tweetQuery
        .listItems((q) => q.likedByUsers)
        .map((item) => item.value)
        .contains(currentUserId);
  }

  bool get isAuthorBlocked {
    final blockedUsers = context
        .query<MeQuery>()
        .listItems(
          (q) => q.blockedUsers,
        )
        .map((item) => item.value);
    return blockedUsers.contains(author.id);
  }

  String get attachmentUrl {
    return tweetQuery.value((q) => q.attachmentUrl);
  }

  String? get likeUserKey {
    return tweetQuery
        .listItems((q) => q.likedByUsers)
        .where((i) => i.value == context.hordaAuthUserId)
        .firstOrNull
        ?.key;
  }

  Future<void> toggleLikeTweet() async {
    final result = await context.runProcess(
      ToggleTweetLikeRequested(likeUserKey, id),
    );
    if (result.isError) {
      throw TweetException(
        result.value ?? 'Failed to toggle tweet like.',
      );
    }
  }

  Future<void> retweet() async {
    final myTimelineId = context.query<MeQuery>().refId((q) => q.timeline);

    final followerCount = context.query<MeQuery>().listLength(
      (q) => q.followers,
    );

    final followerTimelineIds = <String>[
      for (var i = 0; i < followerCount; i++)
        context
            .query<MeQuery>()
            .listItemQuery((q) => q.followers, i)
            .refId((q) => q.timeline),
    ];

    final result = await context.runProcess(
      RetweetRequested(
        id,
        [
          myTimelineId,
          ...followerTimelineIds,
        ],
      ),
    );

    if (result.isError) {
      throw TweetException(result.value ?? 'Failed to retweet.');
    }
  }
}

class TweetException implements Exception {
  final String message;

  const TweetException(this.message);

  @override
  String toString() => 'TweetException: $message';
}
