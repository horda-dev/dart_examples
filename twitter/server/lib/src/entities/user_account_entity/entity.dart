import 'package:horda_server/horda_server.dart';

import 'messages.dart';
import 'state.dart';

/// Represents a user account in the system.
///
/// {@category Entity}
class UserAccountEntity extends Entity<UserAccountEntityState> {
  Future<UserCreated> createUser(CreateUser cmd, EntityContext context) async {
    return UserCreated(cmd.handle, cmd.email, cmd.profileId);
  }

  /// For command description, see [ToggleFollower].
  Future<RemoteEvent> toggleFollower(
    ToggleFollower cmd,
    UserAccountEntityState state,
    EntityContext context,
  ) async {
    if (state.followers.contains(cmd.userId)) {
      return FollowerRemoved(cmd.userId);
    } else {
      return FollowerAdded(cmd.userId);
    }
  }

  /// For command description, see [ToggleFollowing].
  Future<RemoteEvent> toggleFollowing(
    ToggleFollowing cmd,
    UserAccountEntityState state,
    EntityContext context,
  ) async {
    if (state.following.contains(cmd.userId)) {
      return FollowingRemoved(cmd.userId);
    } else {
      return FollowingAdded(cmd.userId);
    }
  }

  @override
  void initHandlers(EntityHandlers<UserAccountEntityState> handlers) {
    handlers.addStateFromJson(UserAccountEntityState.fromJson);
    handlers.addInit<CreateUser, UserCreated>(
      createUser,
      CreateUser.fromJson,
      UserAccountEntityState.fromUserCreated,
    );

    handlers.add<ToggleFollower>(toggleFollower, ToggleFollower.fromJson);
    handlers.add<ToggleFollowing>(toggleFollowing, ToggleFollowing.fromJson);
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {}
}
