import 'package:horda_server/horda_server.dart';
import 'package:twitter_server/twitter_server.dart';

import 'messages.dart';

/// View group of [CommentEntity].
///
/// {@category View Group}
class CommentViewGroup implements EntityViewGroup {
  CommentViewGroup()
    : likedByUsersView = RefListView<UserAccountEntity>(
        name: 'commentLikedByUsersView',
      ),
      parentCommentView = RefView<CommentEntity>(
        name: 'parentCommentView',
        value: null,
      ),
      parentTweetView = RefView<TweetEntity>(
        name: 'parentTweetView',
        value: null,
      ),
      repliesView = RefListView<CommentEntity>(name: 'repliesView'),
      likeCountView = CounterView(name: 'commentLikeCountView'),
      createdAtView = ValueView<DateTime>(
        name: 'commentCreatedAtView',
        value: DateTime.fromMicrosecondsSinceEpoch(0),
      ),
      textView = ValueView<String>(
        name: 'commentTextView',
        value: '',
      ),
      authorUserView = RefView<UserProfileEntity>(
        name: 'commentAuthorUserView',
        value: null,
      );

  CommentViewGroup.fromInitEvent(CommentCreated event)
    : likedByUsersView = RefListView<UserAccountEntity>(
        name: 'commentLikedByUsersView',
      ),
      parentCommentView = RefView<CommentEntity>(
        name: 'parentCommentView',
        value: event.parentCommentId,
      ),
      parentTweetView = RefView<TweetEntity>(
        name: 'parentTweetView',
        value: event.parentTweetId,
      ),
      repliesView = RefListView<CommentEntity>(name: 'repliesView'),
      likeCountView = CounterView(name: 'commentLikeCountView'),
      createdAtView = ValueView<DateTime>(
        name: 'commentCreatedAtView',
        value: DateTime.now().toUtc(), // Use UTC time
      ),
      textView = ValueView<String>(
        name: 'commentTextView',
        value: event.text,
      ),
      authorUserView = RefView<UserProfileEntity>(
        name: 'commentAuthorUserView',
        value: event.authorUserId,
      );

  /// View for the list of users who liked the comment
  final RefListView<UserAccountEntity> likedByUsersView;

  /// View referencing the parent comment entity
  final RefView<CommentEntity> parentCommentView;

  /// View referencing the parent tweet of the comment
  final RefView<TweetEntity> parentTweetView;

  /// View for the list of replies to the comment
  final RefListView<CommentEntity> repliesView;

  /// View for the number of likes on the comment
  final CounterView likeCountView;

  /// View for the comment creation date and time
  final ValueView<DateTime> createdAtView;

  /// View for the comment text
  final ValueView<String> textView;

  /// View for the comment author user's profile
  final RefView<UserProfileEntity> authorUserView;

  void commentLiked(CommentLiked event) {
    likedByUsersView.addItem(event.userId);
    likeCountView.increment(1);
  }

  void commentUnliked(CommentUnliked event) {
    likedByUsersView.removeItem(event.userId);
    likeCountView.decrement(1);
  }

  void commentReplyAdded(CommentReplyAdded event) {
    repliesView.addItem(event.replyCommentId);
  }

  @override
  void initViews(ViewGroup views) {
    views
      ..add(likedByUsersView)
      ..add(parentCommentView)
      ..add(parentTweetView)
      ..add(repliesView)
      ..add(likeCountView)
      ..add(createdAtView)
      ..add(textView)
      ..add(authorUserView);
  }

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {
    projectors
      ..addInit<CommentCreated>(CommentViewGroup.fromInitEvent)
      ..add<CommentLiked>(commentLiked)
      ..add<CommentUnliked>(commentUnliked)
      ..add<CommentReplyAdded>(commentReplyAdded);
  }
}
