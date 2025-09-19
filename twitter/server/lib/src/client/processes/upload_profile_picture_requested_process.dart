import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twitter_server/twitter_server.dart';

part 'upload_profile_picture_requested_process.g.dart';

/// {@category Process}
///
/// Handles the business process for uploading a user's profile picture.
///
/// Flow:
/// 1. Sends 'UploadProfilePicture' command to the MediaStoreService.
/// 2. Waits for 'ProfilePictureUploaded' or 'ProfilePictureUploadFailed' event.
/// 3. If upload failed, returns failure reason.
/// 4. Sends 'UpdateProfilePictureUrl' command to the UserProfileEntity.
/// 5. Waits for 'ProfilePictureUrlUpdated' event.
/// 6. Completes the process.
Future<FlowResult> clientUploadProfilePictureRequested(
  ClientUploadProfilePictureRequested event,
  ProcessContext context,
) async {
  final uploadResult = await context.callServiceDynamic(
    name: 'MediaStoreService',
    cmd: UploadProfilePicture(context.senderId, event.imageDataBase64),
    fac: [
      ProfilePictureUploaded.fromJson,
      ProfilePictureUploadFailed.fromJson,
    ],
  );

  if (uploadResult is ProfilePictureUploadFailed) {
    return FlowResult.error(uploadResult.reason);
  }

  uploadResult as ProfilePictureUploaded;

  final updateResult = await context.callEntity<ProfilePictureUrlUpdated>(
    name: 'UserProfileEntity',
    id: event.profileId,
    cmd: UpdateProfilePictureUrl(uploadResult.pictureUrl),
    fac: ProfilePictureUrlUpdated.fromJson,
  );

  if (updateResult.oldAvatarUrl.isNotEmpty) {
    context.sendService(
      name: 'MediaStoreService',
      cmd: RemoveProfilePicture(updateResult.oldAvatarUrl),
    );
  }

  return FlowResult.ok(uploadResult.pictureUrl);
}

/// {@category Client Event}
@JsonSerializable()
class ClientUploadProfilePictureRequested extends RemoteEvent {
  ClientUploadProfilePictureRequested(this.profileId, this.imageDataBase64);

  /// User's profile ID
  final String profileId;

  /// Base64 encoded image data for the profile picture
  final String imageDataBase64;

  factory ClientUploadProfilePictureRequested.fromJson(
    Map<String, dynamic> json,
  ) {
    return _$ClientUploadProfilePictureRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientUploadProfilePictureRequestedToJson(this);
  }
}
