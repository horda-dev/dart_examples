import 'package:horda_server/horda_server.dart';
import 'package:twitter_server/twitter_server.dart';

import 'messages.dart';

/// View group of [UserAccountEntity].
///
/// {@category View Group}
class UserAccountViewGroup implements EntityViewGroup {
  UserAccountViewGroup()
      : followingView = RefListView<UserAccountEntity>(name: 'followingView'),
        followersView = RefListView<UserAccountEntity>(name: 'followersView'),
        followingCountView = CounterView(name: 'followingCountView'),
        followerCountView = CounterView(name: 'followerCountView'),
        registeredAtView = ValueView<DateTime>(
          name: 'registeredAtView',
          value: DateTime.fromMicrosecondsSinceEpoch(0),
        ),
        profileView = RefView<UserProfileEntity>(name: 'profileView', value: null),
        emailView = ValueView<String>(name: 'emailView', value: ''),
        handleView = ValueView<String>(name: 'handleView', value: ''),
        timelineView = RefView<TimelineEntity>(name: 'timelineView', value: null);

  UserAccountViewGroup.fromInitEvent(UserCreated event)
      : followingView = RefListView<UserAccountEntity>(name: 'followingView'),
        followersView = RefListView<UserAccountEntity>(name: 'followersView'),
        followingCountView = CounterView(name: 'followingCountView'),
        followerCountView = CounterView(name: 'followerCountView'),
        registeredAtView = ValueView<DateTime>(
          name: 'registeredAtView',
          value: DateTime.now().toUtc(),
        ),
        profileView = RefView<UserProfileEntity>(name: 'profileView', value: event.profileId),
        emailView = ValueView<String>(name: 'emailView', value: event.email),
        handleView = ValueView<String>(name: 'handleView', value: event.handle),
        timelineView = RefView<TimelineEntity>(name: 'timelineView', value: null); // Assuming timeline ID is user ID

  /// View for the list of users followed
  final RefListView<UserAccountEntity> followingView;

  /// View for the list of followers
  final RefListView<UserAccountEntity> followersView;

  /// View for the count of users followed
  final CounterView followingCountView;

  /// View for the count of followers
  final CounterView followerCountView;

  /// View for the account registration date and time
  final ValueView<DateTime> registeredAtView;

  /// View for the user's profile
  final RefView<UserProfileEntity> profileView;

  /// View for the user's email
  final ValueView<String> emailView;

  /// View for the user's handle
  final ValueView<String> handleView;

  /// View that references the user's timeline entity
  final RefView<TimelineEntity> timelineView;

  void followerAdded(FollowerAdded event) {
    followersView.addItem(event.userId);
    followerCountView.increment(1);
  }

  void followerRemoved(FollowerRemoved event) {
    followersView.removeItem(event.userId);
    followerCountView.decrement(1);
  }

  void followingAdded(FollowingAdded event) {
    followingView.addItem(event.userId);
    followingCountView.increment(1);
  }

  void followingRemoved(FollowingRemoved event) {
    followingView.removeItem(event.userId);
    followingCountView.decrement(1);
  }

  @override
  void initViews(ViewGroup views) {
    views
      ..add(followingView)
      ..add(followersView)
      ..add(followingCountView)
      ..add(followerCountView)
      ..add(registeredAtView)
      ..add(profileView)
      ..add(emailView)
      ..add(handleView)
      ..add(timelineView);
  }

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {
    projectors
      ..addInit<UserCreated>(UserAccountViewGroup.fromInitEvent)
      ..add<FollowerAdded>(followerAdded)
      ..add<FollowerRemoved>(followerRemoved)
      ..add<FollowingAdded>(followingAdded)
      ..add<FollowingRemoved>(followingRemoved);
  }
}
