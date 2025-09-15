import 'package:horda_server/horda_server.dart';
import 'package:twitter_server/twitter_server.dart';

import 'messages.dart';

/// View group of [CommentEntity].
///
/// {@category View Group}
class CommentViewGroup implements EntityViewGroup {
  CommentViewGroup();

  /// View for the list of users who liked the comment
  final RefListView<UserAccountEntity> likedByUsersView =
      RefListView<UserAccountEntity>(name: 'likedByUsersView');

  /// View referencing the parent comment entity
  final RefView<CommentEntity> parentCommentView = RefView<CommentEntity>(
    name: 'parentCommentView',
    value: null,
  );

  /// View referencing the parent tweet of the comment
  final RefView<TweetEntity> parentTweetView = RefView<TweetEntity>(
    name: 'parentTweetView',
    value: null,
  );

  /// View for the list of replies to the comment
  final RefListView<CommentEntity> repliesView = RefListView<CommentEntity>(
    name: 'repliesView',
  );

  /// View for the number of likes on the comment
  final CounterView likeCountView = CounterView(name: 'likeCountView');

  /// View for the comment creation date and time
  final ValueView<DateTime> createdAtView = ValueView<DateTime>(
    name: 'createdAtView',
    value: DateTime.fromMicrosecondsSinceEpoch(0),
  );

  /// View for the comment text
  final ValueView<String> textView = ValueView<String>(
    name: 'textView',
    value: '',
  );

  /// View for the comment author user's profile
  final RefView<UserProfileEntity> authorUserView = RefView<UserProfileEntity>(
    name: 'authorUserView',
    value: null,
  );

  @override
  void initViews(ViewGroup views) {}

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {}
}
