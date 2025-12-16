import 'package:horda_client/horda_client.dart';

class TweetQuery extends EntityQuery {
  @override
  String get entityName => 'TweetEntity';

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

  final commentCount = EntityCounterView(
    'commentCountView',
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
      ..add(commentCount)
      ..add(likedByUsers)
      ..add(attachmentUrl);
  }
}

class TweetCommentsQuery extends EntityQuery {
  @override
  String get entityName => 'TweetEntity';

  final comments = EntityListView(
    'commentsView',
    query: CommentQuery(),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views.add(comments);
  }
}

class CommentQuery extends EntityQuery {
  @override
  String get entityName => 'CommentEntity';

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
  @override
  String get entityName => 'CommentEntity';

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
  @override
  String get entityName => 'UserAccountEntity';

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

  final blockedCount = EntityCounterView(
    'blockedCountView',
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
      ..add(blockedCount)
      ..add(registeredAt);
  }
}

class UserProfileQuery extends EntityQuery {
  @override
  String get entityName => 'UserProfileEntity';

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
  @override
  String get entityName => 'UserAccountEntity';

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
  @override
  String get entityName => 'UserProfileEntity';

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
  @override
  String get entityName => 'UserAccountEntity';

  final timeline = EntityRefView(
    'timelineView',
    query: EmptyQuery(),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views.add(timeline);
  }
}

class TimelineQuery extends EntityQuery {
  TimelineQuery({
    this.endBefore = '',
    this.pageSize = 10,
  });

  final String endBefore;
  final int pageSize;

  @override
  String get entityName => 'TimelineEntity';

  late final tweets = EntityListView<TweetQuery>(
    'timelineTweetsView',
    query: TweetQuery(),
    pagination: ReversePagination(
      endBefore: endBefore,
      limitToLast: pageSize,
    ),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views.add(tweets);
  }
}

class ExploreFeedQuery extends EntityQuery {
  ExploreFeedQuery({
    this.endBefore = '',
    this.pageSize = 10,
  });

  final String endBefore;
  final int pageSize;

  @override
  String get entityName => 'ExploreFeedEntity';

  late final tweets = EntityListView<TweetQuery>(
    'exploreFeedTweetsView',
    query: TweetQuery(),
    pagination: ReversePagination(
      endBefore: endBefore,
      limitToLast: pageSize,
    ),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views.add(tweets);
  }
}

/// App-wide query used all over the application, to hide blocked user tweets, etc.
class MeQuery extends EntityQuery {
  @override
  String get entityName => 'UserAccountEntity';

  final blockedUsers = EntityListView(
    'blockedUsersView',
    query: EmptyQuery(),
  );

  final following = EntityListView(
    'followingView',
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
      ..add(following)
      ..add(followers)
      ..add(timeline);
  }
}

class MyFollowerQuery extends EntityQuery {
  @override
  String get entityName => 'UserAccountEntity';

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
  @override
  String get entityName => 'UserAccountEntity';

  final following = EntityListView(
    'followingView',
    query: BasicUserInfoQuery(),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views.add(following);
  }
}

class UserFollowersQuery extends EntityQuery {
  @override
  String get entityName => 'UserAccountEntity';

  final followers = EntityListView(
    'followersView',
    query: BasicUserInfoQuery(),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views.add(followers);
  }
}

class BlockedUsersQuery extends EntityQuery {
  @override
  String get entityName => 'UserAccountEntity';

  final blockedUsers = EntityListView(
    'blockedUsersView',
    query: BasicUserInfoQuery(),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views.add(blockedUsers);
  }
}
