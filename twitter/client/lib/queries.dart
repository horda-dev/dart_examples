import 'package:horda_client/horda_client.dart';

class TweetQuery extends EntityQuery {
  final authorUser = EntityRefView(
    'authorUserView',
    query: BasicUserInfoQuery(),
  );

  final text = EntityValueView<String>(
    'textView',
  );

  final createdAt = EntityDateTimeView(
    'createdAtView',
    isUtc: true,
  );

  final likeCount = EntityCounterView(
    'likeCountView',
  );

  final retweetCount = EntityCounterView(
    'retweetCountView',
  );

  final comments = EntityListView(
    'commentsView',
    query: CommentQuery(),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(authorUser)
      ..add(text)
      ..add(createdAt)
      ..add(likeCount)
      ..add(retweetCount)
      ..add(comments);
  }
}

class CommentQuery extends EntityQuery {
  final authorUser = EntityRefView(
    'authorUserView',
    query: BasicUserInfoQuery(),
  );

  final text = EntityValueView<String>(
    'textView',
  );

  final createdAt = EntityDateTimeView(
    'createdAtView',
    isUtc: true,
  );

  final likeCount = EntityCounterView(
    'likeCountView',
  );

  final replies = EntityListView<CommentQuery>(
    'repliesView',
    query: CommentQuery(),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(authorUser)
      ..add(text)
      ..add(createdAt)
      ..add(likeCount)
      ..add(replies);
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

  final followers = EntityListView(
    'followersView',
    query: BasicUserInfoQuery(),
  );

  final following = EntityListView(
    'followingView',
    query: BasicUserInfoQuery(),
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
      ..add(followers)
      ..add(following)
      ..add(followerCount)
      ..add(followingCount)
      ..add(registeredAt);
  }
}

class UserProfileQuery extends EntityQuery {
  final displayName = EntityValueView<String>('displayNameView');
  final bio = EntityValueView<String>('bioView');

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(displayName)
      ..add(bio);
  }
}

class BasicUserInfoQuery extends EntityQuery {
  final handle = EntityValueView<String>('handleView');
  final profile = EntityRefView('profileView', query: DisplayNameQuery());

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(handle)
      ..add(profile);
  }
}

class DisplayNameQuery extends EntityQuery {
  final displayName = EntityValueView<String>('displayNameView');

  @override
  void initViews(EntityQueryGroup views) {
    views.add(displayName);
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
  final tweets = EntityListView<TweetQuery>('tweetsView', query: TweetQuery());

  @override
  void initViews(EntityQueryGroup views) {
    views.add(tweets);
  }
}

class ExploreFeedQuery extends EntityQuery {
  final tweets = EntityListView<TweetQuery>('tweetsView', query: TweetQuery());

  @override
  void initViews(EntityQueryGroup views) {
    views.add(tweets);
  }
}
