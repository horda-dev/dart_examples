import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_server/twitter_server.dart';

import '../queries.dart';
import '../shared/author_user_view_model.dart';
import 'tweet_details_exception.dart';

class TweetDetailsViewModel {
  final BuildContext context;
  final HordaClientSystem system;

  TweetDetailsViewModel(this.context)
    : system = HordaSystemProvider.of(context);

  EntityQueryDependencyBuilder<TweetQuery> get tweetQuery {
    return context.query<TweetQuery>();
  }

  AuthorUserViewModel get author {
    return AuthorUserViewModel(
      tweetQuery.ref((q) => q.authorUser),
    );
  }

  String get id {
    return tweetQuery.id();
  }

  String get text {
    return tweetQuery.value((q) => q.text);
  }

  int get likeCount {
    return tweetQuery.counter((q) => q.likeCount);
  }

  int get retweetCount {
    return tweetQuery.counter((q) => q.retweetCount);
  }

  String get createdAt {
    return _formatTimestamp(
      tweetQuery.value((q) => q.createdAt),
    );
  }

  bool get isLikedByCurrentUser {
    final currentUserId = context.hordaAuthUserId;
    if (currentUserId == null) return false;
    return tweetQuery.listItems((q) => q.likedByUsers).contains(currentUserId);
  }

  int get commentsLength => tweetQuery.listLength((q) => q.comments);

  CommentViewModel getComment(int index) {
    return CommentViewModel(
      context,
      system,
      tweetQuery.listItem((q) => q.comments, index),
      index,
    );
  }

  Future<void> toggleLikeTweet() async {
    final result = await system.dispatchEvent(
      ClientToggleTweetLikeRequested(id),
    );
    if (result.isError) {
      throw TweetDetailsException(result.value ?? 'Failed to toggle like.');
    }
  }

  Future<void> retweet() async {
    final result = await system.dispatchEvent(
      ClientRetweetRequested(id, []),
    );
    if (result.isError) {
      throw TweetDetailsException(result.value ?? 'Failed to retweet.');
    }
  }

  Future<void> addComment(String commentText) async {
    final result = await system.dispatchEvent(
      ClientCreateCommentRequested(
        text: commentText,
        parentTweetId: id,
        parentCommentId: null,
      ),
    );
    if (result.isError) {
      throw TweetDetailsException(result.value ?? 'Failed to add comment.');
    }
  }
}

class CommentViewModel {
  final BuildContext context;
  final HordaClientSystem system;

  final EntityQueryDependencyBuilder<CommentQuery> commentQuery;
  final int index;

  CommentViewModel(this.context, this.system, this.commentQuery, this.index);

  AuthorUserViewModel get author {
    return AuthorUserViewModel(
      commentQuery.ref((q) => q.authorUser),
    );
  }

  String get id {
    return commentQuery.id();
  }

  String get text {
    return commentQuery.value((q) => q.text);
  }

  int get likeCount {
    return commentQuery.counter((q) => q.likeCount);
  }

  String get createdAt {
    return _formatTimestamp(
      commentQuery.value((q) => q.createdAt),
    );
  }

  bool get isLikedByCurrentUser {
    final currentUserId = context.hordaAuthUserId;
    if (currentUserId == null) return false;
    return commentQuery.listItems((q) => q.likedByUsers).contains(currentUserId);
  }

  Future<void> toggleLikeComment() async {
    final result = await system.dispatchEvent(
      ClientToggleCommentLikeRequested(id),
    );

    if (result.isError) {
      throw TweetDetailsException(
        result.value ?? 'Failed to toggle comment like.',
      );
    }
  }
}

String _formatTimestamp(DateTime timestamp) {
  return '${timestamp.hour}:${timestamp.minute} - ${timestamp.day}/${timestamp.month}/${timestamp.year}';
}
