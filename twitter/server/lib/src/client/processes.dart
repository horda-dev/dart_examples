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

class ClientProcesses extends Process {
  @override
  void initHandlers(ProcessHandlers handlers) {
    handlers.add<ClientRegisterUserRequested>(
      clientRegisterUserRequested,
      ClientRegisterUserRequested.fromJson,
    );
    handlers.add<ClientToggleUserFollowRequested>(
      clientToggleUserFollowRequested,
      ClientToggleUserFollowRequested.fromJson,
    );
    handlers.add<ClientToggleTweetLikeRequested>(
      clientToggleTweetLikeRequested,
      ClientToggleTweetLikeRequested.fromJson,
    );
    handlers.add<ClientRetweetRequested>(
      clientRetweetRequested,
      ClientRetweetRequested.fromJson,
    );
    handlers.add<ClientToggleUserBlockRequested>(
      clientToggleUserBlockRequested,
      ClientToggleUserBlockRequested.fromJson,
    );
    handlers.add<ClientToggleCommentLikeRequested>(
      clientToggleCommentLikeRequested,
      ClientToggleCommentLikeRequested.fromJson,
    );
    handlers.add<ClientCreateCommentRequested>(
      clientCreateCommentRequested,
      ClientCreateCommentRequested.fromJson,
    );
    handlers.add<ClientCreateTweetRequested>(
      clientCreateTweetRequested,
      ClientCreateTweetRequested.fromJson,
    );
    handlers.add<ClientUpdateUserProfileRequested>(
      clientUpdateUserProfileRequested,
      ClientUpdateUserProfileRequested.fromJson,
    );
  }
}
