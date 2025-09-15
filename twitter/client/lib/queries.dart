import 'package:horda_client/horda_client.dart';
import 'package:twitter_server/twitter_server.dart'; // Import server views

// Query for a single Tweet
class TweetQuery extends EntityQuery {
  final authorUser = EntityRefView<UserProfileQuery>(
    'authorUserView',
    query: UserProfileQuery(),
  );
  final text = EntityValueView<String>('textView');
  final createdAt = EntityDateTimeView('createdAtView', isUtc: true);
  final likeCount = EntityCounterView('likeCountView');
  final retweetCount = EntityCounterView('retweetCountView');

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(authorUser)
      ..add(text)
      ..add(createdAt)
      ..add(likeCount)
      ..add(retweetCount);
  }
}

// Query for a User Profile
class UserProfileQuery extends EntityQuery {
  final displayName = EntityValueView<String>('displayNameView');
  final bio = EntityValueView<String>('bioView');
  final followerCount = EntityCounterView('followerCountView');
  final followingCount = EntityCounterView('followingCountView');

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(displayName)
      ..add(bio)
      ..add(followerCount)
      ..add(followingCount);
  }
}

// Query for a User's Timeline
class TimelineQuery extends EntityQuery {
  final tweets = EntityListView<TweetQuery>(
    'tweetsView',
    query: TweetQuery(),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views.add(tweets);
  }
}

// New UserAccountQuery
class UserAccountQuery extends EntityQuery {
  final handle = EntityValueView<String>('handleView');
  final email = EntityValueView<String>('emailView');
  final profile = EntityRefView<UserProfileQuery>(
    'profileView',
    query: UserProfileQuery(),
  );
  final followers = EntityListView<UserAccountQuery>(
    'followersView',
    query: UserAccountQuery(), // Nested query for followers
  );
  final following = EntityListView<UserAccountQuery>(
    'followingView',
    query: UserAccountQuery(), // Nested query for following
  );
  final followerCount = EntityCounterView('followerCountView');
  final followingCount = EntityCounterView('followingCountView');
  final registeredAt = EntityDateTimeView('registeredAtView', isUtc: true);
  final timeline = EntityRefView<TimelineQuery>( // New timeline view
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