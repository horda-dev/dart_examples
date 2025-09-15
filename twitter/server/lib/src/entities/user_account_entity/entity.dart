import 'package:horda_server/horda_server.dart';

import 'messages.dart';
import 'state.dart';

/// Represents a user account in the system.
///
/// {@category Entity}
class UserAccountEntity extends Entity<UserAccountEntityState> {
  Future<UserCreated> createUser(CreateUser cmd, EntityContext context) async {
    // TODO: implement CreateUser handler
    throw UnimplementedError('CreateUser handler is not implemented');
  }

  /// For command description, see [ToggleFollower].
  Future<RemoteEvent> toggleFollower(
    ToggleFollower cmd,
    UserAccountEntityState state,
    EntityContext context,
  ) async {
    // TODO: implement ToggleFollower handler
    throw UnimplementedError('ToggleFollower handler is not implemented');
  }

  /// For command description, see [ToggleFollowing].
  Future<RemoteEvent> toggleFollowing(
    ToggleFollowing cmd,
    UserAccountEntityState state,
    EntityContext context,
  ) async {
    // TODO: implement ToggleFollowing handler
    throw UnimplementedError('ToggleFollowing handler is not implemented');
  }

  @override
  void initHandlers(EntityHandlers<UserAccountEntityState> handlers) {
    // TODO: uncomment when UserAccountEntityState.fromUserCreated is implemented
    // handlers.addInit<CreateUser, UserCreated>(
    //   createUser,
    //   CreateUser.fromJson,
    //   UserAccountEntityState.fromUserCreated,
    // );

    handlers.add<ToggleFollower>(toggleFollower, ToggleFollower.fromJson);
    handlers.add<ToggleFollowing>(toggleFollowing, ToggleFollowing.fromJson);
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {}
}
