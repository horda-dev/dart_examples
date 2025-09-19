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
      likedByUsersView = RefListView<UserAccountEntity>(
        name: 'tweetLikedByUsersView',
      ),
      commentsView = RefListView<CommentEntity>(
        name: 'commentsView',
      ),
      commentCountView = CounterView(
        name: 'commentCountView',
      ),
      createdAtView = ValueView<DateTime>(
        name: 'tweetCreatedAtView',
        value: DateTime.fromMicrosecondsSinceEpoch(0),
      ),
      retweetCountView = CounterView(name: 'retweetCountView'),
      likeCountView = CounterView(name: 'tweetLikeCountView'),
      textView = ValueView<String>(
        name: 'tweetTextView',
        value: '',
      ),
      authorUserView = RefView<UserAccountEntity>(
        name: 'tweetAuthorUserView',
        value: null,
      ),
      attachmentUrl = ValueView<String>(
        name: 'tweetAttachmentUrlView',
        value: '',
      );

  TweetViewGroup.fromInitEvent(TweetCreated event)
    : retweetedByUsersView = RefListView<UserAccountEntity>(
        name: 'retweetedByUsersView',
      ),
      likedByUsersView = RefListView<UserAccountEntity>(
        name: 'tweetLikedByUsersView',
      ),
      commentsView = RefListView<CommentEntity>(
        name: 'commentsView',
      ),
      commentCountView = CounterView(
        name: 'commentCountView',
      ),
      createdAtView = ValueView<DateTime>(
        name: 'tweetCreatedAtView',
        value: DateTime.now().toUtc(),
      ),
      retweetCountView = CounterView(name: 'retweetCountView'),
      likeCountView = CounterView(name: 'tweetLikeCountView'),
      textView = ValueView<String>(
        name: 'tweetTextView',
        value: event.text,
      ),
      authorUserView = RefView<UserAccountEntity>(
        name: 'tweetAuthorUserView',
        value: event.authorUserId,
      ),
      attachmentUrl = ValueView<String>(
        name: 'tweetAttachmentUrlView',
        value: event.attachmentUrl,
      );

  /// View for the list of users who retweeted the tweet
  final RefListView<UserAccountEntity> retweetedByUsersView;

  /// View for the list of users who liked the tweet
  final RefListView<UserAccountEntity> likedByUsersView;

  /// View for the list of comments
  final RefListView<CommentEntity> commentsView;

  /// View for the count of comments
  final CounterView commentCountView;

  /// View for the creation date and time
  final ValueView<DateTime> createdAtView;

  /// View for the number of retweets
  final CounterView retweetCountView;

  /// View for the number of likes
  final CounterView likeCountView;

  /// View for the tweet text
  final ValueView<String> textView;

  /// View for the tweet attachment
  final ValueView<String> attachmentUrl;

  /// View for the author user's account
  final RefView<UserAccountEntity> authorUserView;

  void tweetLiked(TweetLiked event) {
    likedByUsersView.addItem(event.userId);
    likeCountView.increment(1);
  }

  void tweetUnliked(TweetUnliked event) {
    likedByUsersView.removeItem(event.userId);
    likeCountView.decrement(1);
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
      ..add(likedByUsersView)
      ..add(commentsView)
      ..add(commentCountView)
      ..add(createdAtView)
      ..add(retweetCountView)
      ..add(likeCountView)
      ..add(textView)
      ..add(authorUserView)
      ..add(attachmentUrl);
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
