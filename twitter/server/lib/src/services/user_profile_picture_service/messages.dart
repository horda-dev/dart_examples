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

/// Removes a user's profile picture.
///
/// {@category Service Command}
@JsonSerializable()
class RemoveProfilePicture extends RemoteCommand {
  RemoveProfilePicture(this.pictureUrl);

  /// URL of the profile picture to remove
  final String pictureUrl;

  factory RemoveProfilePicture.fromJson(Map<String, dynamic> json) =>
      _$RemoveProfilePictureFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RemoveProfilePictureToJson(this);
}

/// Event indicating a profile picture was successfully removed.
///
/// {@category Service Event}
@JsonSerializable()
class ProfilePictureRemoved extends RemoteEvent {
  ProfilePictureRemoved(this.pictureUrl);

  /// URL of the removed profile picture
  final String pictureUrl;

  factory ProfilePictureRemoved.fromJson(Map<String, dynamic> json) =>
      _$ProfilePictureRemovedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfilePictureRemovedToJson(this);
}

/// Uploads a tweet attachment.
///
/// {@category Service Command}
@JsonSerializable()
class UploadTweetAttachment extends RemoteCommand {
  UploadTweetAttachment(this.tweetId, this.imageDataBase64);

  /// ID of the tweet to which the attachment belongs
  final String tweetId;

  /// Base64 encoded image data
  final String imageDataBase64;

  factory UploadTweetAttachment.fromJson(Map<String, dynamic> json) =>
      _$UploadTweetAttachmentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UploadTweetAttachmentToJson(this);
}

/// Event indicating a tweet attachment was successfully uploaded.
///
/// {@category Service Event}
@JsonSerializable()
class TweetAttachmentUploaded extends RemoteEvent {
  TweetAttachmentUploaded(this.tweetId, this.attachmentUrl);

  /// ID of the tweet to which the attachment belongs
  final String tweetId;

  /// URL of the uploaded attachment
  final String attachmentUrl;

  factory TweetAttachmentUploaded.fromJson(Map<String, dynamic> json) =>
      _$TweetAttachmentUploadedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TweetAttachmentUploadedToJson(this);
}

/// Event indicating a tweet attachment upload failed.
///
/// {@category Service Event}
@JsonSerializable()
class TweetAttachmentUploadFailed extends RemoteEvent {
  TweetAttachmentUploadFailed(this.tweetId, this.reason);

  /// ID of the tweet to which the attachment belongs
  final String tweetId;

  /// Reason for the upload failure
  final String reason;

  factory TweetAttachmentUploadFailed.fromJson(Map<String, dynamic> json) =>
      _$TweetAttachmentUploadFailedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TweetAttachmentUploadFailedToJson(this);
}
