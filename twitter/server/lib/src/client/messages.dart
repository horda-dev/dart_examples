import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

/// {@category Client Event}
@JsonSerializable()
class ClientCreateCommentRequested extends RemoteEvent {
  ClientCreateCommentRequested({
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

  factory ClientCreateCommentRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientCreateCommentRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientCreateCommentRequestedToJson(this);
  }
}

/// {@category Client Event}
@JsonSerializable()
class ClientCreateTweetRequested extends RemoteEvent {
  ClientCreateTweetRequested({
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

  factory ClientCreateTweetRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientCreateTweetRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientCreateTweetRequestedToJson(this);
  }
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

/// {@category Client Event}
@JsonSerializable()
class ClientRetweetRequested extends RemoteEvent {
  ClientRetweetRequested(this.tweetId, this.timelineIds);

  /// ID of the tweet to retweet
  String tweetId;

  /// IDs of timelines in which this tweet will show up
  List<String> timelineIds;

  factory ClientRetweetRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientRetweetRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientRetweetRequestedToJson(this);
  }
}

/// {@category Client Event}
@JsonSerializable()
class ClientToggleCommentLikeRequested extends RemoteEvent {
  ClientToggleCommentLikeRequested(this.commentId);

  /// ID of the comment to like or unlike
  String commentId;

  factory ClientToggleCommentLikeRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientToggleCommentLikeRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientToggleCommentLikeRequestedToJson(this);
  }
}

/// {@category Client Event}
@JsonSerializable()
class ClientToggleTweetLikeRequested extends RemoteEvent {
  ClientToggleTweetLikeRequested(this.tweetId);

  /// ID of the tweet to like or unlike
  String tweetId;

  factory ClientToggleTweetLikeRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientToggleTweetLikeRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientToggleTweetLikeRequestedToJson(this);
  }
}

/// {@category Client Event}
@JsonSerializable()
class ClientToggleUserBlockRequested extends RemoteEvent {
  ClientToggleUserBlockRequested(this.userId);

  /// ID of the user which should be blocked/unblocked
  String userId;

  factory ClientToggleUserBlockRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientToggleUserBlockRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientToggleUserBlockRequestedToJson(this);
  }
}

/// {@category Client Event}
@JsonSerializable()
class ClientToggleUserFollowRequested extends RemoteEvent {
  ClientToggleUserFollowRequested(this.followedUserId);

  /// ID of the user to follow or unfollow
  String followedUserId;

  factory ClientToggleUserFollowRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientToggleUserFollowRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientToggleUserFollowRequestedToJson(this);
  }
}

/// {@category Client Event}
@JsonSerializable()
class ClientUpdateUserProfileRequested extends RemoteEvent {
  ClientUpdateUserProfileRequested({
    required this.profileId,
    required this.displayName,
    required this.bio,
    this.avatarBase64,
  });

  final String profileId;
  final String displayName;
  final String bio;
  final String? avatarBase64;

  factory ClientUpdateUserProfileRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientUpdateUserProfileRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientUpdateUserProfileRequestedToJson(this);
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
