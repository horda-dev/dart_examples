import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_client/queries.dart';
import 'package:twitter_server/twitter_server.dart'; // For events
import '../home/home_models.dart'; // For TweetItem, UserProfileItem
import 'tweet_details_models.dart'; // For CommentItem

class TweetDetailsViewModel {
  final BuildContext context;
  late final HordaClientSystem _hordaSystem;
  late final EntityQueryDependencyBuilder<TweetQuery> _tweetQuery;

  TweetDetailsViewModel(this.context, String tweetId) {
    _hordaSystem = HordaSystemProvider.of(context);
    _tweetQuery = context
        .query<TweetQuery>(); // Get the query for the specific tweet
  }

  // Getters for main tweet details
  TweetItem get tweet {
    final authorAccountQuery = _tweetQuery.ref((q) => q.authorUser);
    final authorProfileQuery = authorAccountQuery.ref((q) => q.profile);
    final authorAccountItem = UserAccountItem(
      id: authorAccountQuery.id(),
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
      id: _tweetQuery.id(), // Assuming TweetQuery has an ID
      author: authorAccountItem,
      text: _tweetQuery.value((q) => q.text),
      createdAt: _tweetQuery.value((q) => q.createdAt),
      likeCount: _tweetQuery.counter((q) => q.likeCount),
      retweetCount: _tweetQuery.counter((q) => q.retweetCount),
    );
  }

  // Getters for comments
  int get commentsLength => _tweetQuery.listLength((q) => q.comments);

  CommentItem getComment(int index) {
    final commentQuery = _tweetQuery.listItem((q) => q.comments, index);
    return _processCommentQuery(commentQuery);
  }

  CommentItem _processCommentQuery(
    EntityQueryDependencyBuilder<CommentQuery> commentQuery,
  ) {
    final authorAccountQuery = commentQuery.ref((q) => q.authorUser);
    final authorProfileQuery = authorAccountQuery.ref((q) => q.profile);
    final authorAccountItem = UserAccountItem(
      id: authorAccountQuery.id(),
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

    final repliesLength = commentQuery.listLength((q) => q.replies);
    final List<CommentItem> replies = [];
    for (int i = 0; i < repliesLength; i++) {
      replies.add(
        _processCommentQuery(commentQuery.listItem((q) => q.replies, i)),
      );
    }

    return CommentItem(
      id: commentQuery.id(),
      author: authorAccountItem,
      text: commentQuery.value((q) => q.text),
      createdAt: commentQuery.value((q) => q.createdAt),
      likeCount: commentQuery.counter((q) => q.likeCount),
      replies: replies,
    );
  }

  // Interaction methods
  Future<void> toggleLikeTweet(String tweetId) async {
    final result = await _hordaSystem.dispatchEvent(
      ClientToggleTweetLikeRequested(tweetId),
    );
    if (result.isError) {
      throw Exception(result.value ?? 'Failed to toggle like.');
    }
  }

  Future<void> retweet(String tweetId) async {
    final result = await _hordaSystem.dispatchEvent(
      ClientRetweetRequested(tweetId),
    );
    if (result.isError) {
      throw Exception(result.value ?? 'Failed to retweet.');
    }
  }

  Future<void> addComment(String tweetId, String commentText) async {
    // This is a placeholder, actual implementation needs current user ID.
    final authorUserId = _hordaSystem.authState.value is AuthStateLoggedIn
        ? (_hordaSystem.authState.value as AuthStateLoggedIn).userId
        : 'dummy-user-id';

    final result = await _hordaSystem.dispatchEvent(
      ClientCreateCommentRequested(
        authorUserId: authorUserId,
        text: commentText,
        parentTweetId: tweetId,
        parentCommentId: null, // Or provide a parent comment ID if it's a reply
      ),
    );
    if (result.isError) {
      throw Exception(result.value ?? 'Failed to add comment.');
    }
  }

  Future<void> toggleLikeComment(String commentId) async {
    final result = await _hordaSystem.dispatchEvent(
      ClientToggleCommentLikeRequested(commentId),
    );
    if (result.isError) {
      throw Exception(result.value ?? 'Failed to toggle comment like.');
    }
  }
}
