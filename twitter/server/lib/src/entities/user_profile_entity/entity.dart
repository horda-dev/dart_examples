import 'package:horda_server/horda_server.dart';

import 'messages.dart';
import 'state.dart';

/// Represents a user's profile information.
///
/// {@category Entity}
class UserProfileEntity extends Entity<UserProfileEntityState> {
  Future<UserProfileCreated> createUserProfile(
    CreateUserProfile cmd,
    EntityContext context,
  ) async {
    return UserProfileCreated(
      cmd.accountId,
      cmd.displayName,
      cmd.avatarUrl,
    );
  }

  /// For command description, see [UpdateProfilePictureUrl].
  Future<RemoteEvent> updateProfilePictureUrl(
    UpdateProfilePictureUrl cmd,
    UserProfileEntityState state,
    EntityContext context,
  ) async {
    return ProfilePictureUrlUpdated(cmd.avatarUrl, state.avatarUrl);
  }

  @override
  void initHandlers(EntityHandlers<UserProfileEntityState> handlers) {
    handlers.addStateFromJson(UserProfileEntityState.fromJson);
    handlers.addInit<CreateUserProfile, UserProfileCreated>(
      createUserProfile,
      CreateUserProfile.fromJson,
      UserProfileEntityState.fromUserProfileCreated,
    );

    handlers.add<UpdateProfilePictureUrl>(
      updateProfilePictureUrl,
      UpdateProfilePictureUrl.fromJson,
    );
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {}
}
