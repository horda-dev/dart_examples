import 'package:horda_server/horda_server.dart';
import 'package:twitter_server/twitter_server.dart';

import '../messages.dart';

/// {@category Process}
///
/// Handles the business process for updating a user's profile.
///
/// Flow:
/// 1. If avatarBase64 is provided:
///    a. Sends 'UploadProfilePicture' to MediaStoreService.
///    b. Waits for 'ProfilePictureUploaded' or 'ProfilePictureUploadFailed' event.
///    c. If upload failed, returns failure reason.
///    d. Sends 'UpdateProfilePictureUrl' command to the UserProfileEntity.
///    e. Waits for 'ProfilePictureUrlUpdated' event.
///    f. If oldAvatarUrl is provided in ProfilePictureUrlUpdated, sends 'RemoveProfilePicture' to MediaStoreService.
/// 2. Sends 'UpdateUserProfile' command to the UserProfileEntity to update display name and bio.
/// 3. Waits for 'UserProfileUpdated' event.
/// 4. Completes the process.
Future<FlowResult> clientUpdateUserProfileRequested(
  ClientUpdateUserProfileRequested event,
  ProcessContext context,
) async {
  if (event.avatarBase64 != null) {
    final uploadResult = await context.callServiceDynamic(
      name: 'MediaStoreService',
      cmd: UploadProfilePicture(context.senderId!, event.avatarBase64!),
      fac: [
        ProfilePictureUploaded.fromJson,
        ProfilePictureUploadFailed.fromJson,
      ],
    );

    if (uploadResult is ProfilePictureUploadFailed) {
      return FlowResult.error(uploadResult.reason);
    }

    uploadResult as ProfilePictureUploaded;

    final updatePictureResult = await context
        .callEntity<ProfilePictureUrlUpdated>(
          name: 'UserProfileEntity',
          id: event.profileId,
          cmd: UpdateProfilePictureUrl(uploadResult.pictureUrl),
          fac: ProfilePictureUrlUpdated.fromJson,
        );

    if (updatePictureResult.oldAvatarUrl.isNotEmpty) {
      context.sendService(
        name: 'MediaStoreService',
        cmd: RemoveProfilePicture(updatePictureResult.oldAvatarUrl),
      );
    }
  }

  await context.callEntity<UserProfileUpdated>(
    name: 'UserProfileEntity',
    id: event.profileId,
    cmd: UpdateUserProfile(event.displayName, event.bio),
    fac: UserProfileUpdated.fromJson,
  );

  return FlowResult.ok();
}
