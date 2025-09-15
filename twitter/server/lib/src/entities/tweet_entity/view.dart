import 'package:horda_server/horda_server.dart';
import 'package:twitter_server/twitter_server.dart';

import 'messages.dart';

/// View group of [TweetEntity].
///
/// {@category View Group}
class TweetViewGroup implements EntityViewGroup {
  TweetViewGroup();

  /// View for the list of users who retweeted the tweet
  final RefListView<UserAccountEntity> retweetedByUsersView =
      RefListView<UserAccountEntity>(name: 'retweetedByUsersView');

  /// View for the list of users who liked the tweet
  final RefListView<UserAccountEntity> likedByUsersView =
      RefListView<UserAccountEntity>(name: 'likedByUsersView');

  /// View for the list of comments
  final RefListView<CommentEntity> commentsView = RefListView<CommentEntity>(
    name: 'commentsView',
  );

  /// View for the creation date and time
  final ValueView<DateTime> createdAtView = ValueView<DateTime>(
    name: 'createdAtView',
    value: DateTime.fromMicrosecondsSinceEpoch(0),
  );

  /// View for the number of retweets
  final CounterView retweetCountView = CounterView(name: 'retweetCountView');

  /// View for the number of likes
  final CounterView likeCountView = CounterView(name: 'likeCountView');

  /// View for the tweet text
  final ValueView<String> textView = ValueView<String>(
    name: 'textView',
    value: '',
  );

  /// View for the author user's profile
  final RefView<UserProfileEntity> authorUserView = RefView<UserProfileEntity>(
    name: 'authorUserView',
    value: null,
  );

  @override
  void initViews(ViewGroup views) {}

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {}
}
