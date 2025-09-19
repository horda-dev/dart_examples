import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twitter_server/twitter_server.dart'; // Import twitter_server.dart

part 'toggle_user_follow_requested_process.g.dart';

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
      cmd: ToggleFollower(context.senderId), // The current user is the follower
      fac: [
        FollowerAdded.fromJson,
        FollowerRemoved.fromJson,
      ],
    ),
    context.callEntityDynamic(
      name: 'UserAccountEntity',
      id: context.senderId, // The current user
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
