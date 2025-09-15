import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_user_requested_process.g.dart';

/// {@category Process}
///
/// Handles the user registration business process.
///
/// Steps:
/// 1. Sends 'CreateUser' command to the UserAccountEntity.
/// 2. Waits for 'UserCreated' event. If successful, proceeds; otherwise, ends in error.
/// 3. Sends 'CreateUserProfile' command to the UserProfileEntity.
/// 4. Waits for 'UserProfileCreated' event. If successful, proceeds; otherwise, ends in error.
/// 5. Sends 'SendUserRegistrationEmail' command to the NotificationService.
/// 6. Waits for 'UserRegistrationEmailSent' event. If successful, process completes.
Future<FlowResult> clientRegisterUserRequested(
  ClientRegisterUserRequested event,
  ProcessContext context,
) async {
  /*
  // 1. Send 'CreateUser' to UserAccountEntity and wait for 'UserCreated'
  final userCreated = await context.callActor(
    name: 'UserAccountEntity',
    id: event.userAccountId,
    cmd: CreateUser(),
    fac: UserCreated.fromJson,
  );
  // 2. (If failure, return error - only success events are handled)

  // 3. Send 'CreateUserProfile' to UserProfileEntity and wait for 'UserProfileCreated'
  final userProfileCreated = await context.callActor(
    name: 'UserProfileEntity',
    id: event.userProfileId,
    cmd: CreateUserProfile(),
    fac: UserProfileCreated.fromJson,
  );
  // 4. (If failure, return error - only success events are handled)

  // 5. Send 'SendUserRegistrationEmail' to NotificationService and wait for 'UserRegistrationEmailSent'
  final registrationEmailSent = await context.callService(
    name: 'NotificationService',
    cmd: SendUserRegistrationEmail(),
    fac: UserRegistrationEmailSent.fromJson,
  );
  // 6. (If failure, return error - only success events are handled)

  return FlowResult.ok();
  */
  // TODO: Implement RegisterUserRequested
  return FlowResult.error("Unimplemented");
}

/// {@category Client Event}
@JsonSerializable()
class ClientRegisterUserRequested extends RemoteEvent {
  ClientRegisterUserRequested(this.handle, this.displayName, this.email);

  /// User's unique handle
  String handle;

  /// User's display name
  String displayName;

  /// User's email address
  String email;

  factory ClientRegisterUserRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientRegisterUserRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientRegisterUserRequestedToJson(this);
  }
}
