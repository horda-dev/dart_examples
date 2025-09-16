import 'package:horda_client/horda_client.dart';

// Query for a single Tweet
class TweetQuery extends EntityQuery {
  final authorUser = EntityRefView<UserAccountQuery>(
    'authorUserView',
    query: UserAccountQuery(),
  );
  final text = EntityValueView<String>('textView');
  final createdAt = EntityDateTimeView('createdAtView', isUtc: true);
  final likeCount = EntityCounterView('likeCountView');
  final retweetCount = EntityCounterView('retweetCountView');
  final comments = EntityListView<CommentQuery>(
    'commentsView', // Assuming TweetViewGroup has a commentsView
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

// Query for a User Profile
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

// Query for a User's Timeline
class TimelineQuery extends EntityQuery {
  final tweets = EntityListView<TweetQuery>('tweetsView', query: TweetQuery());

  @override
  void initViews(EntityQueryGroup views) {
    views.add(tweets);
  }
}

// New UserAccountQuery
class UserAccountQuery extends EntityQuery {
  final handle = EntityValueView<String>('handleView');
  final email = EntityValueView<String>('emailView');
  final profile = EntityRefView('profileView', query: UserProfileQuery());
  final followers = EntityListView(
    'followersView',
    query: UserAccountQuery(), // Nested query for followers
  );
  final following = EntityListView(
    'followingView',
    query: UserAccountQuery(), // Nested query for following
  );
  final followerCount = EntityCounterView('followerCountView');
  final followingCount = EntityCounterView('followingCountView');
  final registeredAt = EntityDateTimeView('registeredAtView', isUtc: true);
  final timeline = EntityRefView(
    // New timeline view
    'timelineView',
    query: TimelineQuery(),
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
      ..add(registeredAt)
      ..add(timeline); // Add timeline view
  }
}

// Query for a single Comment
class CommentQuery extends EntityQuery {
  final authorUser = EntityRefView('authorUserView', query: UserAccountQuery());
  final text = EntityValueView<String>('textView');
  final createdAt = EntityDateTimeView('createdAtView', isUtc: true);
  final likeCount = EntityCounterView('likeCountView');
  final replies = EntityListView<CommentQuery>(
    // Nested replies
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

// Query for Explore Feed
class ExploreFeedQuery extends EntityQuery {
  final tweets = EntityListView<TweetQuery>('tweetsView', query: TweetQuery());

  @override
  void initViews(EntityQueryGroup views) {
    views.add(tweets);
  }
}
