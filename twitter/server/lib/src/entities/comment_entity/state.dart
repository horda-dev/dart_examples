import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

import 'entity.dart';
import 'messages.dart';

part 'state.g.dart';

/// State of [CommentEntity].
///
/// {@category Entity State}
@JsonSerializable(constructor: '_json')
class CommentEntityState implements EntityState {
  CommentEntityState._json(
    this.authorUserId,
    this.text,
    this.parentTweetId,
    this.parentCommentId,
    this._likedByUsers,
    this._replyCommentIds,
    this.createdAt,
  );

  // Named constructor instead of factory
  CommentEntityState.fromCommentCreated(CommentCreated event)
    : authorUserId = event.authorUserId,
      text = event.text,
      parentTweetId = event.parentTweetId,
      parentCommentId = event.parentCommentId,
      _likedByUsers = [], // Initial empty list for likedByUsers
      _replyCommentIds = [], // Initial empty list for replyCommentIds
      createdAt = DateTime.now().toUtc(); // Set creation time in UTC

  final String authorUserId;
  final String text;
  final String parentTweetId;
  final String? parentCommentId; // Make nullable
  final DateTime createdAt;

  /// List of user IDs who liked the comment
  List<String> get likedByUsers => _likedByUsers;

  /// List of user IDs who liked the comment
  @JsonKey(name: 'likedByUsers', includeToJson: true, includeFromJson: true)
  List<String> _likedByUsers;

  /// List of comment IDs that are replies to this comment
  List<String> get replyCommentIds => _replyCommentIds;

  /// List of comment IDs that are replies to this comment
  @JsonKey(name: 'replyCommentIds', includeToJson: true, includeFromJson: true)
  List<String> _replyCommentIds;

  // Projection methods moved before project method
  void commentLiked(CommentLiked event) {
    _likedByUsers.add(event.userId);
  }

  void commentUnliked(CommentUnliked event) {
    _likedByUsers.remove(event.userId);
  }

  void commentReplyAdded(CommentReplyAdded event) {
    _replyCommentIds.add(event.replyCommentId);
  }

  @override
  void project(RemoteEvent event) {
    return switch (event) {
      CommentLiked() => commentLiked(event), // Using EventType() syntax
      CommentUnliked() => commentUnliked(event), // Using EventType() syntax
      CommentReplyAdded() => commentReplyAdded(
        event,
      ), // Using EventType() syntax
      _ => null,
    };
  }

  factory CommentEntityState.fromJson(Map<String, dynamic> json) {
    return _$CommentEntityStateFromJson(json);
  }
  @override
  Map<String, dynamic> toJson() {
    return _$CommentEntityStateToJson(this);
  }
}
