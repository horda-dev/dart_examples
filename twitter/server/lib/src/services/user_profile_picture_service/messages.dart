import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

/// Uploads a user's profile picture.
///
/// {@category Service Command}
@JsonSerializable()
class UploadProfilePicture extends RemoteCommand {
  UploadProfilePicture(this.userId, this.imageDataBase64);

  /// ID of the user whose profile picture is being uploaded
  final String userId;

  /// Base64 encoded image data
  final String imageDataBase64;

  factory UploadProfilePicture.fromJson(Map<String, dynamic> json) =>
      _$UploadProfilePictureFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UploadProfilePictureToJson(this);
}

/// Event indicating a profile picture was successfully uploaded.
///
/// {@category Service Event}
@JsonSerializable()
class ProfilePictureUploaded extends RemoteEvent {
  ProfilePictureUploaded(this.userId, this.pictureUrl);

  /// ID of the user whose profile picture was uploaded
  final String userId;

  /// URL of the uploaded profile picture
  final String pictureUrl;

  factory ProfilePictureUploaded.fromJson(Map<String, dynamic> json) =>
      _$ProfilePictureUploadedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfilePictureUploadedToJson(this);
}

/// Event indicating a profile picture upload failed.
///
/// {@category Service Event}
@JsonSerializable()
class ProfilePictureUploadFailed extends RemoteEvent {
  ProfilePictureUploadFailed(this.userId, this.reason);

  /// ID of the user whose profile picture upload failed
  final String userId;

  /// Reason for the upload failure
  final String reason;

  factory ProfilePictureUploadFailed.fromJson(Map<String, dynamic> json) =>
      _$ProfilePictureUploadFailedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfilePictureUploadFailedToJson(this);
}
