import 'dart:convert';

import 'package:horda_server/horda_server.dart';
import 'package:twitter_server/src/common/services/google_cloud/google_cloud.dart';
import 'package:xid/xid.dart';

import 'messages.dart';

/// Manages user profile pictures, including uploading to a Firebase bucket.
///
/// {@category Service}
class UserProfilePictureService extends Service {
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

      final pictureUrl = await kGoogleCloud.saveToResizedBucket(
        fileName: fileName,
        contentType: 'image/jpeg',
        imageBytes: imageBytes,
      );

      return ProfilePictureUploaded(cmd.userId, pictureUrl);
    } catch (e) {
      return ProfilePictureUploadFailed(cmd.userId, e.toString());
    }
  }

  @override
  void initHandlers(ServiceHandlers handlers) {
    handlers.add<UploadProfilePicture>(
      uploadProfilePicture,
      UploadProfilePicture.fromJson,
    );
  }
}
