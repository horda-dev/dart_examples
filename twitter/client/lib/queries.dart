import 'package:horda_client/horda_client.dart';

class TweetQuery extends EntityQuery {
  final authorUser = EntityRefView(
    'tweetAuthorUserView',
    query: BasicUserInfoQuery(),
  );

  final text = EntityValueView<String>(
    'tweetTextView',
  );

  final createdAt = EntityDateTimeView(
    'tweetCreatedAtView',
    isUtc: true,
  );

  final likeCount = EntityCounterView(
    'tweetLikeCountView',
  );

  final retweetCount = EntityCounterView(
    'retweetCountView',
  );

  final comments = EntityListView(
    'commentsView',
    query: CommentQuery(),
  );

  final likedByUsers = EntityListView(
    'tweetLikedByUsersView',
    query: BasicUserInfoQuery(),
  );

  final attachmentUrl = EntityValueView<String>(
    'tweetAttachmentUrlView',
  );

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(authorUser)
      ..add(text)
      ..add(createdAt)
      ..add(likeCount)
      ..add(retweetCount)
      ..add(comments)
      ..add(likedByUsers)
      ..add(attachmentUrl);
  }
}

class CommentQuery extends EntityQuery {
  final authorUser = EntityRefView(
    'commentAuthorUserView',
    query: BasicUserInfoQuery(),
  );

  final text = EntityValueView<String>(
    'commentTextView',
  );

  final createdAt = EntityDateTimeView(
    'commentCreatedAtView',
    isUtc: true,
  );

  final likeCount = EntityCounterView(
    'commentLikeCountView',
  );

  final replies = EntityListView<CommentReplyQuery>(
    'repliesView',
    query: CommentReplyQuery(),
  );

  final likedByUsers = EntityListView(
    'commentLikedByUsersView',
    query: BasicUserInfoQuery(),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(authorUser)
      ..add(text)
      ..add(createdAt)
      ..add(likeCount)
      ..add(replies)
      ..add(likedByUsers);
  }
}

class CommentReplyQuery extends EntityQuery {
  final authorUser = EntityRefView(
    'commentAuthorUserView',
    query: BasicUserInfoQuery(),
  );

  final text = EntityValueView<String>(
    'commentTextView',
  );

  final createdAt = EntityDateTimeView(
    'commentCreatedAtView',
    isUtc: true,
  );

  final likeCount = EntityCounterView(
    'commentLikeCountView',
  );

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(authorUser)
      ..add(text)
      ..add(createdAt)
      ..add(likeCount);
  }
}

class UserAccountQuery extends EntityQuery {
  final handle = EntityValueView<String>(
    'handleView',
  );

  final email = EntityValueView<String>(
    'emailView',
  );

  final profile = EntityRefView(
    'profileView',
    query: UserProfileQuery(),
  );

  final followerCount = EntityCounterView(
    'followerCountView',
  );

  final followingCount = EntityCounterView(
    'followingCountView',
  );

  final registeredAt = EntityDateTimeView(
    'registeredAtView',
    isUtc: true,
  );

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(handle)
      ..add(email)
      ..add(profile)
      ..add(followerCount)
      ..add(followingCount)
      ..add(registeredAt);
  }
}

class UserProfileQuery extends EntityQuery {
  final displayName = EntityValueView<String>('displayNameView');
  final avatarUrl = EntityValueView<String>('avatarUrlView');
  final bio = EntityValueView<String>('bioView');

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(displayName)
      ..add(avatarUrl)
      ..add(bio);
  }
}

class BasicUserInfoQuery extends EntityQuery {
  final handle = EntityValueView<String>('handleView');
  final profile = EntityRefView(
    'profileView',
    query: UserNameAndPictureQuery(),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(handle)
      ..add(profile);
  }
}

class UserNameAndPictureQuery extends EntityQuery {
  final displayName = EntityValueView<String>('displayNameView');
  final avatarUrl = EntityValueView<String>('avatarUrlView');

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(displayName)
      ..add(avatarUrl);
  }
}

class UserTimelineQuery extends EntityQuery {
  final timeline = EntityRefView('timelineView', query: TimelineQuery());

  @override
  void initViews(EntityQueryGroup views) {
    views.add(timeline);
  }
}

class TimelineQuery extends EntityQuery {
  final tweets = EntityListView<TweetQuery>(
    'timelineTweetsView',
    query: TweetQuery(),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views.add(tweets);
  }
}

class ExploreFeedQuery extends EntityQuery {
  final tweets = EntityListView<TweetQuery>(
    'exploreFeedTweetsView',
    query: TweetQuery(),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views.add(tweets);
  }
}

/// App-wide query used all over the application, to hide blocked user tweets, etc.
class MeQuery extends EntityQuery {
  final blockedUsers = EntityListView(
    'blockedUsersView',
    query: EmptyQuery(),
  );

  final followers = EntityListView(
    'followersView',
    query: MyFollowerQuery(),
  );

  final timeline = EntityRefView(
    'timelineView',
    query: EmptyQuery(),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(blockedUsers)
      ..add(followers)
      ..add(timeline);
  }
}

class MyFollowerQuery extends EntityQuery {
  final timeline = EntityRefView(
    'timelineView',
    query: EmptyQuery(),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views.add(timeline);
  }
}

class UserFollowingQuery extends EntityQuery {
  final following = EntityListView(
    'followingView',
    query: BasicUserInfoQuery(),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views.add(following);
  }
}
