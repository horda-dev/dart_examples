import 'package:horda_server/horda_server.dart';
import 'package:xid/xid.dart';

import '../../../twitter_server.dart';

/// {@category Process}
///
/// Handles the user registration business process.
///
/// Steps:
/// 1. Sends 'UploadProfilePicture' to MediaStoreService.
/// 2. Waits for 'ProfilePictureUploaded' or 'ProfilePictureFailed'.
/// 3. If upload failed, returns error with failure reason.
/// 4. Sends 'CreateUserProfile' command to the UserProfileEntity.
/// 5. Waits for 'UserProfileCreated' event. If successful, proceeds; otherwise, ends in error.
/// 6. Sends 'CreateTimeline' command to the TimelineEntity.
/// 7. Waits for 'TimelineCreated' event. If successful, proceeds; otherwise, ends in error.
/// 8. Sends 'CreateUserAccount' command to the UserAccountEntity.
/// 9. Waits for 'UserAccountCreated' event. If successful, proceeds; otherwise, ends in error.
/// 10. Sends 'SendUserRegistrationEmail' command to the NotificationService.
Future<ProcessResult> clientRegisterUserRequested(
  ClientRegisterUserRequested event,
  ProcessContext context,
) async {
  final userAccountId = context.senderId!;
  final userProfileId = Xid().toString();
  final userTimelineId = Xid().toString();

  final result = await context.callServiceDynamic(
    name: 'MediaStoreService',
    cmd: UploadProfilePicture(userAccountId, event.avatarBase64),
    fac: [
      ProfilePictureUploaded.fromJson,
      ProfilePictureUploadFailed.fromJson,
    ],
  );

  if (result is ProfilePictureUploadFailed) {
    return ProcessResult.error(result.reason);
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

  await context.callEntity<TimelineCreated>(
    name: 'TimelineEntity',
    id: userTimelineId,
    cmd: CreateTimeline(userAccountId),
    fac: TimelineCreated.fromJson,
  );

  await context.callEntity<UserAccountCreated>(
    name: 'UserAccountEntity',
    id: userAccountId,
    cmd: CreateUserAccount(
      event.handle,
      event.email,
      userProfileId,
      userTimelineId,
    ),
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

  return ProcessResult.ok();
}
