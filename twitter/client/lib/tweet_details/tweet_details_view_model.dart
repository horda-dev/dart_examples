import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_server/twitter_server.dart';

import '../queries.dart';
import '../shared/author_user_view_model.dart';
import '../shared/tweet_view_model.dart';
import 'tweet_details_exception.dart';

class TweetDetailsViewModel extends TweetViewModel {
  TweetDetailsViewModel(BuildContext context)
    : super(context, context.query<TweetQuery>());

  String get createdAtString {
    return _formatTimestamp(createdAt);
  }

  Future<void> addComment(String commentText) async {
    final result = await context.runProcess(
      CreateCommentRequested(
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

class CommentListViewModel {
  final BuildContext context;

  CommentListViewModel(this.context);

  EntityQueryDependencyBuilder<TweetCommentsQuery> get commentsQuery {
    return context.query<TweetCommentsQuery>();
  }

  String get tweetId {
    return commentsQuery.id();
  }

  int get commentsLength => commentsQuery.listLength((q) => q.comments);

  CommentViewModel getComment(int index) {
    return CommentViewModel(
      context,
      commentsQuery.listItemQuery((q) => q.comments, index),
      index,
    );
  }
}

class CommentViewModel {
  final BuildContext context;

  final EntityQueryDependencyBuilder<CommentQuery> commentQuery;
  final int index;

  CommentViewModel(this.context, this.commentQuery, this.index);

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
    return commentQuery
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

  String? get likeUserKey {
    return commentQuery
        .listItems((q) => q.likedByUsers)
        .where((i) => i.value == context.hordaAuthUserId)
        .firstOrNull
        ?.key;
  }

  Future<void> toggleLikeComment() async {
    final result = await context.runProcess(
      ToggleCommentLikeRequested(likeUserKey, id),
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
