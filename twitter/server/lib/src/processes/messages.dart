import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

/// {@category Client Event}
@JsonSerializable()
class CreateCommentRequested extends RemoteEvent {
  CreateCommentRequested({
    required this.text,
    required this.parentTweetId,
    this.parentCommentId,
  });

  /// Text content of the comment
  final String text;

  /// ID of the parent tweet (required)
  final String parentTweetId;

  /// ID of the parent comment (optional, for replies to comments)
  final String? parentCommentId;

  factory CreateCommentRequested.fromJson(Map<String, dynamic> json) {
    return _$CreateCommentRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CreateCommentRequestedToJson(this);
  }
}

/// {@category Client Event}
@JsonSerializable()
class CreateTweetRequested extends RemoteEvent {
  CreateTweetRequested({
    required this.authorUserId,
    required this.text,
    required this.attachmentBase64,
    required this.timelineIds,
  });

  /// ID of the user who authored the tweet
  final String authorUserId;

  /// Text content of the tweet
  final String text;

  /// An image attached to the tweet, in base64 encoding
  final String? attachmentBase64;

  /// IDs of timelines in which this tweet will show up
  final List<String> timelineIds;

  factory CreateTweetRequested.fromJson(Map<String, dynamic> json) {
    return _$CreateTweetRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CreateTweetRequestedToJson(this);
  }
}

/// {@category Client Event}
@JsonSerializable()
class RegisterUserRequested extends RemoteEvent {
  RegisterUserRequested(
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

  factory RegisterUserRequested.fromJson(Map<String, dynamic> json) {
    return _$RegisterUserRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$RegisterUserRequestedToJson(this);
  }
}

/// {@category Client Event}
@JsonSerializable()
class RetweetRequested extends RemoteEvent {
  RetweetRequested(this.tweetId, this.timelineIds);

  /// ID of the tweet to retweet
  String tweetId;

  /// IDs of timelines in which this tweet will show up
  List<String> timelineIds;

  factory RetweetRequested.fromJson(Map<String, dynamic> json) {
    return _$RetweetRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$RetweetRequestedToJson(this);
  }
}

/// {@category Client Event}
@JsonSerializable()
class ToggleCommentLikeRequested extends RemoteEvent {
  ToggleCommentLikeRequested(this.commentId);

  /// ID of the comment to like or unlike
  String commentId;

  factory ToggleCommentLikeRequested.fromJson(Map<String, dynamic> json) {
    return _$ToggleCommentLikeRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ToggleCommentLikeRequestedToJson(this);
  }
}

/// {@category Client Event}
@JsonSerializable()
class ToggleTweetLikeRequested extends RemoteEvent {
  ToggleTweetLikeRequested(this.tweetId);

  /// ID of the tweet to like or unlike
  String tweetId;

  factory ToggleTweetLikeRequested.fromJson(Map<String, dynamic> json) {
    return _$ToggleTweetLikeRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ToggleTweetLikeRequestedToJson(this);
  }
}

/// {@category Client Event}
@JsonSerializable()
class ToggleUserBlockRequested extends RemoteEvent {
  ToggleUserBlockRequested(this.userId);

  /// ID of the user which should be blocked/unblocked
  String userId;

  factory ToggleUserBlockRequested.fromJson(Map<String, dynamic> json) {
    return _$ToggleUserBlockRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ToggleUserBlockRequestedToJson(this);
  }
}

/// {@category Client Event}
@JsonSerializable()
class ToggleUserFollowRequested extends RemoteEvent {
  ToggleUserFollowRequested(this.followedUserId);

  /// ID of the user to follow or unfollow
  String followedUserId;

  factory ToggleUserFollowRequested.fromJson(Map<String, dynamic> json) {
    return _$ToggleUserFollowRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ToggleUserFollowRequestedToJson(this);
  }
}

/// {@category Client Event}
@JsonSerializable()
class UpdateUserProfileRequested extends RemoteEvent {
  UpdateUserProfileRequested({
    required this.profileId,
    required this.displayName,
    required this.bio,
    this.avatarBase64,
  });

  final String profileId;
  final String displayName;
  final String bio;
  final String? avatarBase64;

  factory UpdateUserProfileRequested.fromJson(Map<String, dynamic> json) {
    return _$UpdateUserProfileRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UpdateUserProfileRequestedToJson(this);
  }
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
