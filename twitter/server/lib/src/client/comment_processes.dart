import 'package:horda_server/horda_server.dart';

import 'processes/create_comment_requested_process.dart';
import 'processes/toggle_comment_like_requested_process.dart';
import 'messages.dart';

class CommentProcesses extends ProcessGroup {
  @override
  void registerFuncs(ProcessFuncs funcs) {
    funcs.add<ClientCreateCommentRequested>(
      clientCreateCommentRequested,
      ClientCreateCommentRequested.fromJson,
    );
    funcs.add<ClientToggleCommentLikeRequested>(
      clientToggleCommentLikeRequested,
      ClientToggleCommentLikeRequested.fromJson,
    );
  }
}
