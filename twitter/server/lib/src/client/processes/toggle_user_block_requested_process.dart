import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twitter_server/twitter_server.dart'; // Import twitter_server.dart

part 'toggle_user_block_requested_process.g.dart';

/// {@category Process}
///
/// Handles the ToggleUserBlockRequested business process:
/// 1. Sends 'ToggleUserBlock' command to 'UserAccountEntity'.
/// 2. Waits for 'UserBlocked' or 'UserUnblocked' event.
/// 3. Completes the process upon successful toggling.
Future<FlowResult> clientToggleUserBlockRequested(
  ClientToggleUserBlockRequested event,
  ProcessContext context,
) async {
  await context.callEntityDynamic(
    name: 'UserAccountEntity',
    id: context.senderId!,
    cmd: ToggleUserBlock(
      event.userId,
    ),
    fac: [
      UserBlocked.fromJson,
      UserUnblocked.fromJson,
    ],
  );

  return FlowResult.ok();
}

/// {@category Client Event}
@JsonSerializable()
class ClientToggleUserBlockRequested extends RemoteEvent {
  ClientToggleUserBlockRequested(this.userId);

  /// ID of the user which should be blocked/unblocked
  String userId;

  factory ClientToggleUserBlockRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientToggleUserBlockRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientToggleUserBlockRequestedToJson(this);
  }
}
