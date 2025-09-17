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
/// 1. Sends 'UploadProfilePicture' to UserProfilePictureService.
/// 2. Waits for 'ProfilePictureUploaded' or 'ProfilePictureFailed'.
/// 3. If upload failed, returns error with failure reason.
/// 4. Sends 'CreateUserAccount' command to the UserAccountEntity.
/// 5. Waits for 'UserAccountCreated' event. If successful, proceeds; otherwise, ends in error.
/// 6. Sends 'CreateUserProfile' command to the UserProfileEntity.
/// 7. Waits for 'UserProfileCreated' event. If successful, proceeds; otherwise, ends in error.
/// 8. Sends 'SendUserRegistrationEmail' command to the NotificationService.
Future<FlowResult> clientRegisterUserRequested(
  ClientRegisterUserRequested event,
  ProcessContext context,
) async {
  final userAccountId = context.senderId;
  final userProfileId = Xid().toString();

  final result = await context.callServiceDynamic(
    name: 'UserProfilePictureService',
    cmd: UploadProfilePicture(userAccountId, event.avatarBase64),
    fac: [
      ProfilePictureUploaded.fromJson,
      ProfilePictureUploadFailed.fromJson,
    ],
  );

  if (result is ProfilePictureUploadFailed) {
    return FlowResult.error(result.reason);
  }

  result as ProfilePictureUploaded;

  await context.callEntity<UserProfileCreated>(
    name: 'UserProfileEntity',
    id: userProfileId,
    cmd: CreateUserProfile(
      userAccountId,
      event.displayName,
      result.pictureUrl,
    ),
    fac: UserProfileCreated.fromJson,
  );

  await context.callEntity<UserAccountCreated>(
    name: 'UserAccountEntity',
    id: userAccountId,
    cmd: CreateUserAccount(event.handle, event.email, userProfileId),
    fac: UserAccountCreated.fromJson,
  );

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
  ClientRegisterUserRequested(
    this.handle,
    this.displayName,
    this.email,
    this.avatarBase64,
  );

  /// User's unique handle
  String handle;

  /// User's display name
  String displayName;

  /// User's email address
  String email;

  /// User's profile picture in base64 encoding.
  String avatarBase64;

  factory ClientRegisterUserRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientRegisterUserRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientRegisterUserRequestedToJson(this);
  }
}
