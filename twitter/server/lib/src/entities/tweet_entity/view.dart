import 'package:horda_server/horda_server.dart';
import 'package:twitter_server/twitter_server.dart';

import 'messages.dart';

/// View group of [TweetEntity].
///
/// {@category View Group}
class TweetViewGroup implements EntityViewGroup {
  TweetViewGroup()
    : retweetedByUsersView = RefListView<UserAccountEntity>(
        name: 'retweetedByUsersView',
      ),
      tweetLikedByUsersView = RefListView<UserAccountEntity>(
        name: 'tweetLikedByUsersView',
      ),
      commentsView = RefListView<CommentEntity>(
        name: 'commentsView',
      ),
      commentCountView = CounterView(
        name: 'commentCountView',
      ),
      tweetCreatedAtView = ValueView<DateTime>(
        name: 'tweetCreatedAtView',
        value: DateTime.fromMicrosecondsSinceEpoch(0),
      ),
      retweetCountView = CounterView(name: 'retweetCountView'),
      tweetLikeCountView = CounterView(name: 'tweetLikeCountView'),
      tweetTextView = ValueView<String>(
        name: 'tweetTextView',
        value: '',
      ),
      tweetAuthorUserView = RefView<UserAccountEntity>(
        name: 'tweetAuthorUserView',
        value: null,
      ),
      tweetAttachmentUrlView = ValueView<String>(
        name: 'tweetAttachmentUrlView',
        value: '',
      );

  TweetViewGroup.fromInitEvent(TweetCreated event)
    : retweetedByUsersView = RefListView<UserAccountEntity>(
        name: 'retweetedByUsersView',
      ),
      tweetLikedByUsersView = RefListView<UserAccountEntity>(
        name: 'tweetLikedByUsersView',
      ),
      commentsView = RefListView<CommentEntity>(
        name: 'commentsView',
      ),
      commentCountView = CounterView(
        name: 'commentCountView',
      ),
      tweetCreatedAtView = ValueView<DateTime>(
        name: 'tweetCreatedAtView',
        value: DateTime.now().toUtc(),
      ),
      retweetCountView = CounterView(name: 'retweetCountView'),
      tweetLikeCountView = CounterView(name: 'tweetLikeCountView'),
      tweetTextView = ValueView<String>(
        name: 'tweetTextView',
        value: event.text,
      ),
      tweetAuthorUserView = RefView<UserAccountEntity>(
        name: 'tweetAuthorUserView',
        value: event.authorUserId,
      ),
      tweetAttachmentUrlView = ValueView<String>(
        name: 'tweetAttachmentUrlView',
        value: event.attachmentUrl,
      );

  /// View for the list of users who retweeted the tweet
  final RefListView<UserAccountEntity> retweetedByUsersView;

  /// View for the list of users who liked the tweet
  final RefListView<UserAccountEntity> tweetLikedByUsersView;

  /// View for the list of comments
  final RefListView<CommentEntity> commentsView;

  /// View for the count of comments
  final CounterView commentCountView;

  /// View for the creation date and time
  final ValueView<DateTime> tweetCreatedAtView;

  /// View for the number of retweets
  final CounterView retweetCountView;

  /// View for the number of likes
  final CounterView tweetLikeCountView;

  /// View for the tweet text
  final ValueView<String> tweetTextView;

  /// View for the tweet attachment
  final ValueView<String> tweetAttachmentUrlView;

  /// View for the author user's account
  final RefView<UserAccountEntity> tweetAuthorUserView;

  void tweetLiked(TweetLiked event) {
    tweetLikedByUsersView.addItem(event.userId);
    tweetLikeCountView.increment(1);
  }

  void tweetUnliked(TweetUnliked event) {
    tweetLikedByUsersView.removeItem(event.userId);
    tweetLikeCountView.decrement(1);
  }

  void tweetRetweeted(TweetRetweeted event) {
    retweetedByUsersView.addItem(event.userId);
    retweetCountView.increment(1);
  }

  void tweetCommentAdded(TweetCommentAdded event) {
    commentsView.addItem(event.commentId);
    commentCountView.increment(1);
  }

  @override
  void initViews(ViewGroup views) {
    views
      ..add(retweetedByUsersView)
      ..add(tweetLikedByUsersView)
      ..add(commentsView)
      ..add(commentCountView)
      ..add(tweetCreatedAtView)
      ..add(retweetCountView)
      ..add(tweetLikeCountView)
      ..add(tweetTextView)
      ..add(tweetAuthorUserView)
      ..add(tweetAttachmentUrlView);
  }

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {
    projectors
      ..addInit<TweetCreated>(TweetViewGroup.fromInitEvent)
      ..add<TweetLiked>(tweetLiked)
      ..add<TweetUnliked>(tweetUnliked)
      ..add<TweetRetweeted>(tweetRetweeted)
      ..add<TweetCommentAdded>(tweetCommentAdded);
  }
}
