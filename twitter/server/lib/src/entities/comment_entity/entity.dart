import 'package:horda_server/horda_server.dart';

import 'messages.dart';
import 'state.dart';

/// Represents comments on tweets.
///
/// {@category Entity}
class CommentEntity extends Entity<CommentEntityState> {
  Future<CommentCreated> createComment(
    CreateComment cmd,
    EntityContext context,
  ) async {
    return CommentCreated(
      cmd.authorUserId,
      cmd.text,
      cmd.parentTweetId,
      cmd.parentCommentId,
    );
  }

  /// For command description, see [ToggleCommentLike].
  Future<RemoteEvent> toggleCommentLike(
    ToggleCommentLike cmd,
    CommentEntityState state,
    EntityContext context,
  ) async {
    if (state.likedByUsers.contains(cmd.userId)) {
      final userKey = cmd.userKey;

      if (userKey == null) {
        throw ArgumentError.value(
          userKey,
          "userKey",
          "User key must not be null when unliking a comment",
        );
      }

      return CommentUnliked(userKey, cmd.userId);
    }

    return CommentLiked(cmd.userId);
  }

  /// For command description, see [AddCommentReply].
  Future<RemoteEvent> addCommentReply(
    AddCommentReply cmd,
    CommentEntityState state,
    EntityContext context,
  ) async {
    return CommentReplyAdded(cmd.replyCommentId);
  }

  @override
  void initHandlers(EntityHandlers<CommentEntityState> handlers) {
    handlers.addStateFromJson(CommentEntityState.fromJson);
    handlers.addInit<CreateComment, CommentCreated>(
      createComment,
      CreateComment.fromJson,
      CommentEntityState.fromCommentCreated,
    );

    handlers.add<ToggleCommentLike>(
      toggleCommentLike,
      ToggleCommentLike.fromJson,
    );
    handlers.add<AddCommentReply>(addCommentReply, AddCommentReply.fromJson);
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {}
}
