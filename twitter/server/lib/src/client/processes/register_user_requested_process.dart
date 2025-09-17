import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twitter_server/twitter_server.dart';
import 'package:xid/xid.dart'; // Import twitter_server.dart

part 'register_user_requested_process.g.dart';

/// {@category Process}
///
/// Handles the user registration business process.
///
/// Steps:
/// 1. Sends 'CreateUserAccount' command to the UserAccountEntity.
/// 2. Waits for 'UserAccountCreated' event. If successful, proceeds; otherwise, ends in error.
/// 3. Sends 'CreateUserProfile' command to the UserProfileEntity.
/// 4. Waits for 'UserProfileCreated' event. If successful, proceeds; otherwise, ends in error.
/// 5. Sends 'SendUserRegistrationEmail' command to the NotificationService.
Future<FlowResult> clientRegisterUserRequested(
  ClientRegisterUserRequested event,
  ProcessContext context,
) async {
  final userAccountId = context.senderId;
  final userProfileId = Xid().toString();

  // 1-2. Send 'CreateUserProfile' to UserProfileEntity and wait for 'UserProfileCreated'
  await context.callEntity<UserProfileCreated>(
    name: 'UserProfileEntity',
    id: userProfileId,
    cmd: CreateUserProfile(userAccountId, event.displayName),
    fac: UserProfileCreated.fromJson,
  );

  // 3-4. Send 'CreateUserAccount' to UserAccountEntity and wait for 'UserAccountCreated'
  await context.callEntity<UserAccountCreated>(
    name: 'UserAccountEntity',
    id: userAccountId,
    cmd: CreateUserAccount(event.handle, event.email, userProfileId),
    fac: UserAccountCreated.fromJson,
  );

  // 5. Send 'SendUserRegistrationEmail' to NotificationService
  context.sendService(
    name: 'NotificationService',
    cmd: SendUserRegistrationEmail(
      userAccountId,
      event.email,
      event.displayName,
    ),
  );

  return FlowResult.ok();
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
