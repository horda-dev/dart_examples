import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_server/twitter_server.dart';

import '../queries.dart';
import 'author_user_view_model.dart';

class TweetViewModel {
  final BuildContext context;
  final HordaClientSystem system;
  final EntityQueryDependencyBuilder<TweetQuery> tweetQuery;

  TweetViewModel(this.context, this.tweetQuery)
    : system = HordaSystemProvider.of(context);

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

  bool get isLikedByCurrentUser {
    final currentUserId = context.hordaAuthUserId;
    if (currentUserId == null) return false;
    return tweetQuery.listItems((q) => q.likedByUsers).contains(currentUserId);
  }

  String get attachmentUrl {
    return tweetQuery.value((q) => q.attachmentUrl);
  }

  Future<void> toggleLikeTweet() async {
    final result = await system.dispatchEvent(
      ClientToggleCommentLikeRequested(id),
    );
    if (result.isError) {
      throw TweetException(
        result.value ?? 'Failed to toggle tweet like.',
      );
    }
  }

  Future<void> retweet() async {
    final result = await system.dispatchEvent(
      ClientRetweetRequested(id, []),
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
