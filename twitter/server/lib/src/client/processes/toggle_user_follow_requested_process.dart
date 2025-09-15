import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'toggle_user_follow_requested_process.g.dart';

/// {@category Process}
///
/// Handles the ToggleUserFollowRequested business process.
///
/// Flow:
/// 1. Sends 'ToggleFollower' command to UserAccountEntity.
/// 2. Waits for either 'FollowerAdded' or 'FollowerRemoved' event to decide what to do next.
/// 3. Sends 'ToggleFollowing' command to UserAccountEntity.
/// 4. Waits for either 'FollowingAdded' or 'FollowingRemoved' event to decide what to do next.
/// 5. Completes the process.
Future<FlowResult> clientToggleUserFollowRequested(
  ClientToggleUserFollowRequested event,
  ProcessContext context,
) async {
  /*
  // Step 1: Send 'ToggleFollower' to UserAccountEntity
  final followerEvent = await context.callActor<RemoteEvent>(
    name: 'UserAccountEntity',
    id: event.userId,
    cmd: ToggleFollower(),
    fac: RemoteEvent.fromJson,
  );

  // Step 2: Decide if Follower was added or removed
  // (Decide based on followerEvent payload)

  // Step 3: Send 'ToggleFollowing' to UserAccountEntity
  final followingEvent = await context.callActor<RemoteEvent>(
    name: 'UserAccountEntity',
    id: event.targetId,
    cmd: ToggleFollowing(),
    fac: RemoteEvent.fromJson,
  );

  // Step 4: Decide if Following was added or removed
  // (Decide based on followingEvent payload)
  
  // Step 5: Complete process
  return FlowResult.ok();
  */
  // TODO: Implement ToggleUserFollowRequested
  return FlowResult.error("Unimplemented");
}

/// {@category Client Event}
@JsonSerializable()
class ClientToggleUserFollowRequested extends RemoteEvent {
  ClientToggleUserFollowRequested(this.followedUserId);

  /// ID of the user to follow or unfollow
  String followedUserId;

  factory ClientToggleUserFollowRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientToggleUserFollowRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientToggleUserFollowRequestedToJson(this);
  }
}
