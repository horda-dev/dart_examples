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
        name: 'userProfileUpdatedAtView',
        value: DateTime.fromMicrosecondsSinceEpoch(0),
      ),
      bioView = ValueView<String>(name: 'bioView', value: ''),
      displayNameView = ValueView<String>(name: 'displayNameView', value: ''),
      avatarUrlView = ValueView<String>(name: 'avatarUrlView', value: '');

  UserProfileViewGroup.fromUserProfileCreated(UserProfileCreated event)
    : accountView = RefView<UserAccountEntity>(
        name: 'accountView',
        value: event.accountId,
      ),
      updatedAtView = ValueView<DateTime>(
        name: 'userProfileUpdatedAtView',
        value: DateTime.now().toUtc(),
      ),
      bioView = ValueView<String>(name: 'bioView', value: ''),
      displayNameView = ValueView<String>(
        name: 'displayNameView',
        value: event.displayName,
      ),
      avatarUrlView = ValueView<String>(
        name: 'avatarUrlView',
        value: event.avatarUrl,
      );

  /// View that references the associated user account entity
  final RefView<UserAccountEntity> accountView;

  /// View for the profile's last updated date and time
  final ValueView<DateTime> updatedAtView;

  /// View for the user's bio
  final ValueView<String> bioView;

  /// View for the user's display name
  final ValueView<String> displayNameView;

  /// View for the user's avatar URL
  final ValueView<String> avatarUrlView;

  void profilePictureUrlUpdated(ProfilePictureUrlUpdated event) {
    avatarUrlView.value = event.newAvatarUrl;
    updatedAtView.value = DateTime.now().toUtc();
  }

  void userProfileUpdated(UserProfileUpdated event) {
    displayNameView.value = event.displayName;
    bioView.value = event.bio;
    updatedAtView.value = DateTime.now().toUtc();
  }

  @override
  void initViews(ViewGroup views) {
    views
      ..add(accountView)
      ..add(updatedAtView)
      ..add(bioView)
      ..add(displayNameView)
      ..add(avatarUrlView);
  }

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {
    projectors
      ..addInit<UserProfileCreated>(UserProfileViewGroup.fromUserProfileCreated)
      ..add<ProfilePictureUrlUpdated>(profilePictureUrlUpdated)
      ..add<UserProfileUpdated>(userProfileUpdated);
  }
}
