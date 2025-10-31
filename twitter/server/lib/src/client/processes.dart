import 'package:horda_server/horda_server.dart';

import 'processes/create_comment_requested_process.dart';
import 'processes/create_tweet_requested_process.dart';
import 'processes/register_user_requested_process.dart';
import 'processes/retweet_requested_process.dart';
import 'processes/toggle_comment_like_requested_process.dart';
import 'processes/toggle_tweet_like_requested_process.dart';
import 'processes/toggle_user_block_requested_process.dart';
import 'processes/toggle_user_follow_requested_process.dart';
import 'processes/update_user_profile_requested_process.dart';
import 'messages.dart';

class ClientProcesses extends ProcessGroup {
  @override
  void registerFuncs(ProcessFuncs funcs) {
    funcs.add<ClientRegisterUserRequested>(
      clientRegisterUserRequested,
      ClientRegisterUserRequested.fromJson,
    );
    funcs.add<ClientToggleUserFollowRequested>(
      clientToggleUserFollowRequested,
      ClientToggleUserFollowRequested.fromJson,
    );
    funcs.add<ClientToggleTweetLikeRequested>(
      clientToggleTweetLikeRequested,
      ClientToggleTweetLikeRequested.fromJson,
    );
    funcs.add<ClientRetweetRequested>(
      clientRetweetRequested,
      ClientRetweetRequested.fromJson,
    );
    funcs.add<ClientToggleUserBlockRequested>(
      clientToggleUserBlockRequested,
      ClientToggleUserBlockRequested.fromJson,
    );
    funcs.add<ClientToggleCommentLikeRequested>(
      clientToggleCommentLikeRequested,
      ClientToggleCommentLikeRequested.fromJson,
    );
    funcs.add<ClientCreateCommentRequested>(
      clientCreateCommentRequested,
      ClientCreateCommentRequested.fromJson,
    );
    funcs.add<ClientCreateTweetRequested>(
      clientCreateTweetRequested,
      ClientCreateTweetRequested.fromJson,
    );
    funcs.add<ClientUpdateUserProfileRequested>(
      clientUpdateUserProfileRequested,
      ClientUpdateUserProfileRequested.fromJson,
    );
  }
}
