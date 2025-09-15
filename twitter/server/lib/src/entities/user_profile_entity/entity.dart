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
    // TODO: implement CreateUserProfile handler
    throw UnimplementedError('CreateUserProfile handler is not implemented');
  }

  @override
  void initHandlers(EntityHandlers<UserProfileEntityState> handlers) {
    // TODO: uncomment when UserProfileEntityState.fromUserProfileCreated is implemented
    // handlers.addInit<CreateUserProfile, UserProfileCreated>(
    //   createUserProfile,
    //   CreateUserProfile.fromJson,
    //   UserProfileEntityState.fromUserProfileCreated,
    // );
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {}
}
