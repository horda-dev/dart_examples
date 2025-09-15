import 'package:horda_server/horda_server.dart';
import 'package:twitter_server/twitter_server.dart';

import 'messages.dart';

/// View group of [UserProfileEntity].
///
/// {@category View Group}
class UserProfileViewGroup implements EntityViewGroup {
  UserProfileViewGroup();

  /// View that references the associated user account entity
  final RefView<UserAccountEntity> accountView = RefView<UserAccountEntity>(
    name: 'accountView',
    value: null,
  );

  /// View for the profile's last updated date and time
  final ValueView<DateTime> updatedAtView = ValueView<DateTime>(
    name: 'updatedAtView',
    value: DateTime.fromMicrosecondsSinceEpoch(0),
  );

  /// View for the list of followers
  final RefListView<UserAccountEntity> followersView =
      RefListView<UserAccountEntity>(name: 'followersView');

  /// View for the count of users followed
  final CounterView followingCountView = CounterView(
    name: 'followingCountView',
  );

  /// View for the count of followers
  final CounterView followerCountView = CounterView(name: 'followerCountView');

  /// View for the user's bio
  final ValueView<String> bioView = ValueView<String>(
    name: 'bioView',
    value: '',
  );

  /// View for the user's display name
  final ValueView<String> displayNameView = ValueView<String>(
    name: 'displayNameView',
    value: '',
  );

  @override
  void initViews(ViewGroup views) {}

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {}
}
