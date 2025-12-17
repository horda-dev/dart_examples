import 'package:horda_server/horda_server.dart';

import '../../../twitter_server.dart';

/// View group of [CommentEntity].
///
/// {@category View Group}
class CommentViewGroup implements EntityViewGroup {
  CommentViewGroup()
    : commentLikedByUsersView = RefListView<UserAccountEntity>(
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
      commentLikeCountView = CounterView(name: 'commentLikeCountView'),
      commentCreatedAtView = ValueView<DateTime>(
        name: 'commentCreatedAtView',
        value: DateTime.fromMicrosecondsSinceEpoch(0),
      ),
      commentTextView = ValueView<String>(
        name: 'commentTextView',
        value: '',
      ),
      commentAuthorUserView = RefView<UserAccountEntity>(
        name: 'commentAuthorUserView',
        value: null,
      );

  CommentViewGroup.fromInitEvent(CommentCreated event)
    : commentLikedByUsersView = RefListView<UserAccountEntity>(
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
      commentLikeCountView = CounterView(name: 'commentLikeCountView'),
      commentCreatedAtView = ValueView<DateTime>(
        name: 'commentCreatedAtView',
        value: DateTime.now().toUtc(), // Use UTC time
      ),
      commentTextView = ValueView<String>(
        name: 'commentTextView',
        value: event.text,
      ),
      commentAuthorUserView = RefView<UserAccountEntity>(
        name: 'commentAuthorUserView',
        value: event.authorUserId,
      );

  /// View for the list of users who liked the comment
  final RefListView<UserAccountEntity> commentLikedByUsersView;

  /// View referencing the parent comment entity
  final RefView<CommentEntity> parentCommentView;

  /// View referencing the parent tweet of the comment
  final RefView<TweetEntity> parentTweetView;

  /// View for the list of replies to the comment
  final RefListView<CommentEntity> repliesView;

  /// View for the number of likes on the comment
  final CounterView commentLikeCountView;

  /// View for the comment creation date and time
  final ValueView<DateTime> commentCreatedAtView;

  /// View for the comment text
  final ValueView<String> commentTextView;

  /// View for the comment author user's profile
  final RefView<UserAccountEntity> commentAuthorUserView;

  void commentLiked(CommentLiked event) {
    commentLikedByUsersView.addItem(event.userId);
    commentLikeCountView.increment(1);
  }

  void commentUnliked(CommentUnliked event) {
    commentLikedByUsersView.removeItem(event.userKey);
    commentLikeCountView.decrement(1);
  }

  void commentReplyAdded(CommentReplyAdded event) {
    repliesView.addItem(event.replyCommentId);
  }

  @override
  void initViews(ViewGroup views) {
    views
      ..add(commentLikedByUsersView)
      ..add(parentCommentView)
      ..add(parentTweetView)
      ..add(repliesView)
      ..add(commentLikeCountView)
      ..add(commentCreatedAtView)
      ..add(commentTextView)
      ..add(commentAuthorUserView);
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
