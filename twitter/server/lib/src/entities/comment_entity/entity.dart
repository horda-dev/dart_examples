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
    // TODO: implement CreateComment handler
    throw UnimplementedError('CreateComment handler is not implemented');
  }

  /// For command description, see [ToggleCommentLike].
  Future<RemoteEvent> toggleCommentLike(
    ToggleCommentLike cmd,
    CommentEntityState state,
    EntityContext context,
  ) async {
    // TODO: implement ToggleCommentLike handler
    throw UnimplementedError('ToggleCommentLike handler is not implemented');
  }

  /// For command description, see [AddCommentReply].
  Future<RemoteEvent> addCommentReply(
    AddCommentReply cmd,
    CommentEntityState state,
    EntityContext context,
  ) async {
    // TODO: implement AddCommentReply handler
    throw UnimplementedError('AddCommentReply handler is not implemented');
  }

  @override
  void initHandlers(EntityHandlers<CommentEntityState> handlers) {
    // TODO: uncomment when CommentEntityState.fromCommentCreated is implemented
    // handlers.addInit<CreateComment, CommentCreated>(
    //   createComment,
    //   CreateComment.fromJson,
    //   CommentEntityState.fromCommentCreated,
    // );

    handlers.add<ToggleCommentLike>(
      toggleCommentLike,
      ToggleCommentLike.fromJson,
    );
    handlers.add<AddCommentReply>(addCommentReply, AddCommentReply.fromJson);
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {}
}
