import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'log_in_user_requested_process.g.dart';

/// {@category Process}
///
/// Handles the business process for logging in a user.
///
/// # Flow:
/// 1. Sends the 'LogInUser' command to the 'UserAccountEntity'.
/// 2. Waits for the 'UserLoggedIn' event to confirm the operation.
/// 3. Completes the process.
Future<FlowResult> clientLogInUserRequested(
  ClientLogInUserRequested event,
  ProcessContext context,
) async {
  /*
  final userLoggedIn = await context.callActor<UserLoggedIn>(
    name: 'UserAccountEntity',
    id: event.userId,
    cmd: LogInUser(),
    fac: UserLoggedIn.fromJson,
  );
  // on event UserLoggedIn, process completes successfully
  */
  // TODO: Implement LogInUserRequested
  return FlowResult.error("Unimplemented");
}

/// {@category Client Event}
@JsonSerializable()
class ClientLogInUserRequested extends RemoteEvent {
  ClientLogInUserRequested();

  factory ClientLogInUserRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientLogInUserRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientLogInUserRequestedToJson(this);
  }
}
