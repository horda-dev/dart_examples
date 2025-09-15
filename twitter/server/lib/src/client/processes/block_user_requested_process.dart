import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'block_user_requested_process.g.dart';

/// {@category Process}
///
/// Handles the BlockUserRequested business process:
/// 1. Sends 'BlockUser' command to 'UserAccountEntity'.
/// 2. Waits for 'UserBlocked' event.
/// 3. Completes the process upon successful blocking.
Future<FlowResult> clientBlockUserRequested(
  ClientBlockUserRequested event,
  ProcessContext context,
) async {
  /*
  // 1. Send 'BlockUser' command to UserAccountEntity and wait for 'UserBlocked' event
  final userBlockedEvent = await context.callActor(
    name: 'UserAccountEntity',
    id: event.userId,
    cmd: BlockUser(),
    fac: UserBlocked.fromJson,
  );

  // 2. Success: UserBlocked event received
  return FlowResult.ok();
  */
  // TODO: Implement BlockUserRequested
  return FlowResult.error("Unimplemented");
}

/// {@category Client Event}
@JsonSerializable()
class ClientBlockUserRequested extends RemoteEvent {
  ClientBlockUserRequested(this.blockedUserId);

  /// ID of the user to block
  String blockedUserId;

  factory ClientBlockUserRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientBlockUserRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientBlockUserRequestedToJson(this);
  }
}
