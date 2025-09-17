import 'package:horda_server/horda_server.dart';

import 'messages.dart';
import 'state.dart';

/// Represents a user account in the system.
///
/// {@category Entity}
class UserAccountEntity extends Entity<UserAccountEntityState> {
  Future<UserAccountCreated> createUser(
    CreateUserAccount cmd,
    EntityContext context,
  ) async {
    return UserAccountCreated(
      cmd.handle,
      cmd.email,
      cmd.profileId,
      cmd.timelineId,
    );
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

  /// For command description, see [ToggleUserBlock].
  Future<RemoteEvent> toggleUserBlock(
    ToggleUserBlock cmd,
    UserAccountEntityState state,
    EntityContext context,
  ) async {
    if (state.blockedUsers.contains(cmd.userId)) {
      return UserUnblocked(cmd.userId);
    } else {
      return UserBlocked(cmd.userId);
    }
  }

  @override
  void initHandlers(EntityHandlers<UserAccountEntityState> handlers) {
    handlers.addStateFromJson(UserAccountEntityState.fromJson);
    handlers.addInit<CreateUserAccount, UserAccountCreated>(
      createUser,
      CreateUserAccount.fromJson,
      UserAccountEntityState.fromUserAccountCreated,
    );

    handlers.add<ToggleFollower>(toggleFollower, ToggleFollower.fromJson);
    handlers.add<ToggleFollowing>(toggleFollowing, ToggleFollowing.fromJson);
    handlers.add<ToggleUserBlock>(toggleUserBlock, ToggleUserBlock.fromJson);
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {}
}
