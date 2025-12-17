import 'package:horda_server/horda_server.dart';
import 'package:xid/xid.dart';

import '../entities/timeline_entity/messages.dart';
import '../entities/user_account_entity/messages.dart';
import '../entities/user_profile_entity/messages.dart';
import '../services/notification_service/messages.dart';
import '../services/media_store_service/messages.dart';
import 'messages.dart';

class UserProcesses extends ProcessGroup {
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
  static Future<ProcessResult> registerUserRequested(
    RegisterUserRequested event,
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
  static Future<ProcessResult> updateUserProfileRequested(
    UpdateUserProfileRequested event,
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
        return ProcessResult.error(uploadResult.reason);
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

    return ProcessResult.ok();
  }

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
  static Future<ProcessResult> toggleUserFollowRequested(
    ToggleUserFollowRequested event,
    ProcessContext context,
  ) async {
    await Future.wait([
      context.callEntityDynamic(
        name: 'UserAccountEntity',
        id: event.followedUserId, // The user being followed/unfollowed
        cmd: ToggleFollower(
          event.followerUserKey,
          context.senderId!, // The current user is the follower
        ),
        fac: [
          FollowerAdded.fromJson,
          FollowerRemoved.fromJson,
        ],
      ),
      context.callEntityDynamic(
        name: 'UserAccountEntity',
        id: context.senderId!, // The current user
        cmd: ToggleFollowing(
          event.followingUserKey,
          event.followedUserId, // The user being followed/unfollowed
        ),
        fac: [
          FollowingAdded.fromJson,
          FollowingRemoved.fromJson,
        ],
      ),
    ]);

    return ProcessResult.ok();
  }

  /// {@category Process}
  ///
  /// Handles the ToggleUserBlockRequested business process:
  /// 1. Sends 'ToggleUserBlock' command to 'UserAccountEntity'.
  /// 2. Waits for 'UserBlocked' or 'UserUnblocked' event.
  /// 3. Completes the process upon successful toggling.
  static Future<ProcessResult> toggleUserBlockRequested(
    ToggleUserBlockRequested event,
    ProcessContext context,
  ) async {
    await context.callEntityDynamic(
      name: 'UserAccountEntity',
      id: context.senderId!,
      cmd: ToggleUserBlock(
        event.userKey,
        event.userId,
      ),
      fac: [
        UserBlocked.fromJson,
        UserUnblocked.fromJson,
      ],
    );

    return ProcessResult.ok();
  }

  @override
  void registerFuncs(ProcessFuncs funcs) {
    funcs.add<RegisterUserRequested>(
      registerUserRequested,
      RegisterUserRequested.fromJson,
    );
    funcs.add<UpdateUserProfileRequested>(
      updateUserProfileRequested,
      UpdateUserProfileRequested.fromJson,
    );
    funcs.add<ToggleUserFollowRequested>(
      toggleUserFollowRequested,
      ToggleUserFollowRequested.fromJson,
    );
    funcs.add<ToggleUserBlockRequested>(
      toggleUserBlockRequested,
      ToggleUserBlockRequested.fromJson,
    );
  }
}
