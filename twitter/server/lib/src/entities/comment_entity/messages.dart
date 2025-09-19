import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

/// Creates a new comment with author user ID, text, and references to parent tweet and comment.
///
/// {@category Entity Command}
@JsonSerializable()
class CreateComment extends RemoteCommand {
  CreateComment(
    this.authorUserId,
    this.text,
    this.parentTweetId,
    this.parentCommentId,
  );

  /// ID of the user who authored the comment
  String authorUserId;

  /// Text content of the comment
  String text;

  /// ID of the parent tweet
  String parentTweetId;

  /// ID of the parent comment
  String? parentCommentId;

  factory CreateComment.fromJson(Map<String, dynamic> json) {
    return _$CreateCommentFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CreateCommentToJson(this);
  }
}

/// Event indicating a comment was created.
///
/// {@category Entity Event}
@JsonSerializable()
class CommentCreated extends RemoteEvent {
  CommentCreated(
    this.authorUserId,
    this.text,
    this.parentTweetId,
    this.parentCommentId,
  );

  /// ID of the user who authored the comment
  String authorUserId;

  /// Text content of the comment
  String text;

  /// ID of the parent tweet
  String parentTweetId;

  /// ID of the parent comment
  String? parentCommentId;

  factory CommentCreated.fromJson(Map<String, dynamic> json) {
    return _$CommentCreatedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CommentCreatedToJson(this);
  }
}

/// Command to toggle a like on a comment.
///
/// {@category Entity Command}
@JsonSerializable()
class ToggleCommentLike extends RemoteCommand {
  ToggleCommentLike(this.userId);

  /// ID of the user toggling like status on the comment
  String userId;

  factory ToggleCommentLike.fromJson(Map<String, dynamic> json) {
    return _$ToggleCommentLikeFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ToggleCommentLikeToJson(this);
  }
}

/// Event indicating a comment was liked.
///
/// {@category Entity Event}
@JsonSerializable()
class CommentLiked extends RemoteEvent {
  CommentLiked(this.userId);

  /// ID of the user who liked the comment
  String userId;

  factory CommentLiked.fromJson(Map<String, dynamic> json) {
    return _$CommentLikedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CommentLikedToJson(this);
  }
}

/// Event indicating a comment was unliked.
///
/// {@category Entity Event}
@JsonSerializable()
class CommentUnliked extends RemoteEvent {
  CommentUnliked(this.userId);

  /// ID of the user who unliked the comment
  String userId;

  factory CommentUnliked.fromJson(Map<String, dynamic> json) {
    return _$CommentUnlikedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CommentUnlikedToJson(this);
  }
}

/// Command to add a reply comment to an existing comment.
///
/// {@category Entity Command}
@JsonSerializable()
class AddCommentReply extends RemoteCommand {
  AddCommentReply(this.replyCommentId);

  /// ID of the reply comment to add
  String replyCommentId;

  factory AddCommentReply.fromJson(Map<String, dynamic> json) {
    return _$AddCommentReplyFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$AddCommentReplyToJson(this);
  }
}

/// Event indicating a reply comment was added.
///
/// {@category Entity Event}
@JsonSerializable()
class CommentReplyAdded extends RemoteEvent {
  CommentReplyAdded(this.replyCommentId);

  /// ID of the reply comment added
  String replyCommentId;

  factory CommentReplyAdded.fromJson(Map<String, dynamic> json) {
    return _$CommentReplyAddedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CommentReplyAddedToJson(this);
  }
}
