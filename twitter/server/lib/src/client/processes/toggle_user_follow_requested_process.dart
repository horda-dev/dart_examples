import 'package:horda_server/horda_server.dart';
import 'package:twitter_server/twitter_server.dart';

import '../messages.dart';

/// {@category Process}
///
/// Handles the ToggleUserFollowRequested business process.
///
/// Flow:
/// 1. Sends 'ToggleFollower' command to UserAccountEntity.
/// 2. Waits for either 'FollowerAdded' or 'FollowerRemoved' event
/// 3. Sends 'ToggleFollowing' command to UserAccountEntity.
/// 4. Waits for either 'FollowingAdded' or 'FollowingRemoved' event
/// 5. Completes the process.
Future<FlowResult> clientToggleUserFollowRequested(
  ClientToggleUserFollowRequested event,
  ProcessContext context,
) async {
  await Future.wait([
    context.callEntityDynamic(
      name: 'UserAccountEntity',
      id: event.followedUserId, // The user being followed/unfollowed
      cmd: ToggleFollower(
        context.senderId!, // The current user is the follower
      ),
      fac: [
        FollowerAdded.fromJson,
        FollowerRemoved.fromJson,
      ],
    ),
    context.callEntityDynamic(
      name: 'UserAccountEntity',
      id: context.senderId!, // The current user
      cmd: ToggleFollowing(
        event.followedUserId, // The user being followed/unfollowed
      ),
      fac: [
        FollowingAdded.fromJson,
        FollowerRemoved.fromJson,
      ],
    ),
  ]);

  return FlowResult.ok();
}
