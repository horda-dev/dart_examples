import 'dart:convert';

import 'package:horda_server/horda_server.dart';
import 'package:xid/xid.dart';

import '../../common/services/google_cloud/google_cloud.dart';
import 'messages.dart';

/// Manages uploading and removing media files to a Firebase bucket.
///
/// {@category Service}
class MediaStoreService extends Service {
  /// For command description, see [UploadProfilePicture].
  Future<RemoteEvent> uploadProfilePicture(
    UploadProfilePicture cmd,
    ServiceContext context,
  ) async {
    try {
      final imageBytes = base64Decode(cmd.imageDataBase64);

      // Check image size (1.5 MB limit)
      const maxSizeInBytes = 1.5 * 1024 * 1024; // 1.5 MB
      if (imageBytes.lengthInBytes > maxSizeInBytes) {
        return ProfilePictureUploadFailed(
          cmd.userId,
          'Image size exceeds 1.5 MB limit.',
        );
      }

      final pictureId = Xid().toString();
      final fileName = 'profile_pictures/${cmd.userId}/$pictureId.jpeg';

      final pictureUrl = await kGoogleCloud.saveToBucket(
        fileName: fileName,
        contentType: 'image/jpeg',
        imageBytes: imageBytes,
      );

      return ProfilePictureUploaded(cmd.userId, pictureUrl);
    } catch (e) {
      return ProfilePictureUploadFailed(cmd.userId, e.toString());
    }
  }

  /// For command description, see [RemoveProfilePicture].
  Future<RemoteEvent> removeProfilePicture(
    RemoveProfilePicture cmd,
    ServiceContext context,
  ) async {
    try {
      await kGoogleCloud.deleteByUrl(cmd.pictureUrl);
      return ProfilePictureRemoved(cmd.pictureUrl);
    } catch (e) {
      throw MediaStoreServiceException(e.toString());
    }
  }

  /// For command description, see [UploadTweetAttachment].
  Future<RemoteEvent> uploadTweetAttachment(
    UploadTweetAttachment cmd,
    ServiceContext context,
  ) async {
    try {
      final imageBytes = base64Decode(cmd.imageDataBase64);

      // Check image size (3 MB limit for tweet attachments)
      const maxSizeInBytes = 3 * 1024 * 1024;
      if (imageBytes.lengthInBytes > maxSizeInBytes) {
        return TweetAttachmentUploadFailed(
          cmd.tweetId,
          'Image size exceeds 3 MB limit.',
        );
      }

      final attachmentId = Xid().toString();
      final fileName = 'tweet_attachments/${cmd.tweetId}/$attachmentId.jpeg';

      final attachmentUrl = await kGoogleCloud.saveToBucket(
        fileName: fileName,
        contentType: 'image/jpeg',
        imageBytes: imageBytes,
      );

      return TweetAttachmentUploaded(cmd.tweetId, attachmentUrl);
    } catch (e) {
      return TweetAttachmentUploadFailed(cmd.tweetId, e.toString());
    }
  }

  @override
  void initHandlers(ServiceHandlers handlers) {
    handlers.add<UploadProfilePicture>(
      uploadProfilePicture,
      UploadProfilePicture.fromJson,
    );
    handlers.add<RemoveProfilePicture>(
      removeProfilePicture,
      RemoveProfilePicture.fromJson,
    );
    handlers.add<UploadTweetAttachment>(
      uploadTweetAttachment,
      UploadTweetAttachment.fromJson,
    );
  }
}

class MediaStoreServiceException implements Exception {
  final String message;

  MediaStoreServiceException(this.message);

  @override
  String toString() {
    return 'MediaStoreServiceException: $message';
  }
}
