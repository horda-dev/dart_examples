import 'package:horda_server/horda_server.dart';
import 'package:twitter_server/twitter_server.dart';

import 'messages.dart';

/// View group of [UserProfileEntity].
///
/// {@category View Group}
class UserProfileViewGroup implements EntityViewGroup {
  UserProfileViewGroup()
    : accountView = RefView<UserAccountEntity>(
        name: 'accountView',
        value: null,
      ),
      updatedAtView = ValueView<DateTime>(
        name: 'updatedAtView',
        value: DateTime.fromMicrosecondsSinceEpoch(0),
      ),
      bioView = ValueView<String>(name: 'bioView', value: ''),
      displayNameView = ValueView<String>(name: 'displayNameView', value: '');

  UserProfileViewGroup.fromUserProfileCreated(UserProfileCreated event)
    : accountView = RefView<UserAccountEntity>(
        name: 'accountView',
        value: event.accountId,
      ),
      updatedAtView = ValueView<DateTime>(
        name: 'updatedAtView',
        value: DateTime.now().toUtc(),
      ),
      bioView = ValueView<String>(name: 'bioView', value: ''),
      displayNameView = ValueView<String>(
        name: 'displayNameView',
        value: event.displayName,
      );

  /// View that references the associated user account entity
  final RefView<UserAccountEntity> accountView;

  /// View for the profile's last updated date and time
  final ValueView<DateTime> updatedAtView;

  /// View for the user's bio
  final ValueView<String> bioView;

  /// View for the user's display name
  final ValueView<String> displayNameView;

  @override
  void initViews(ViewGroup views) {
    views
      ..add(accountView)
      ..add(updatedAtView)
      ..add(bioView)
      ..add(displayNameView);
  }

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {
    projectors.addInit<UserProfileCreated>(
      UserProfileViewGroup.fromUserProfileCreated,
    );
  }
}
