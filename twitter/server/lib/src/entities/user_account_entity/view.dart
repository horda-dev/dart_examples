import 'package:horda_server/horda_server.dart';
import 'package:twitter_server/twitter_server.dart';

import 'messages.dart';

/// View group of [UserAccountEntity].
///
/// {@category View Group}
class UserAccountViewGroup implements EntityViewGroup {
  UserAccountViewGroup();

  /// View for the list of users followed
  final RefListView<UserAccountEntity> followingView =
      RefListView<UserAccountEntity>(name: 'followingView');

  /// View for the list of followers
  final RefListView<UserAccountEntity> followersView =
      RefListView<UserAccountEntity>(name: 'followersView');

  /// View for the count of users followed
  final CounterView followingCountView = CounterView(
    name: 'followingCountView',
  );

  /// View for the count of followers
  final CounterView followerCountView = CounterView(name: 'followerCountView');

  /// View for the account registration date and time
  final ValueView<DateTime> registeredAtView = ValueView<DateTime>(
    name: 'registeredAtView',
    value: DateTime.fromMicrosecondsSinceEpoch(0),
  );

  /// View for the user's profile
  final RefView<UserProfileEntity> profileView = RefView<UserProfileEntity>(
    name: 'profileView',
    value: null,
  );

  /// View for the user's email
  final ValueView<String> emailView = ValueView<String>(
    name: 'emailView',
    value: '',
  );

  /// View for the user's handle
  final ValueView<String> handleView = ValueView<String>(
    name: 'handleView',
    value: '',
  );

  /// View that references the user's timeline entity
  final RefView<TimelineEntity> timelineView = RefView<TimelineEntity>(
    name: 'timelineView',
    value: null,
  );

  @override
  void initViews(ViewGroup views) {}

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {}
}
