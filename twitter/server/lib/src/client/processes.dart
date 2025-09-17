import 'package:horda_server/horda_server.dart';

import 'processes/create_comment_requested_process.dart';
import 'processes/create_tweet_requested_process.dart';
import 'processes/register_user_requested_process.dart';
import 'processes/retweet_requested_process.dart';
import 'processes/toggle_comment_like_requested_process.dart';
import 'processes/toggle_tweet_like_requested_process.dart';
import 'processes/toggle_user_block_requested_process.dart';
import 'processes/toggle_user_follow_requested_process.dart';
import 'processes/upload_profile_picture_requested_process.dart';

class ClientProcesses extends Process {
  Future<FlowResult> registerUserRequested(
    ClientRegisterUserRequested event,
    ProcessContext context,
  ) async {
    return clientRegisterUserRequested(event, context);
  }

  Future<FlowResult> toggleUserFollowRequested(
    ClientToggleUserFollowRequested event,
    ProcessContext context,
  ) async {
    return clientToggleUserFollowRequested(event, context);
  }

  Future<FlowResult> toggleTweetLikeRequested(
    ClientToggleTweetLikeRequested event,
    ProcessContext context,
  ) async {
    return clientToggleTweetLikeRequested(event, context);
  }

  Future<FlowResult> retweetRequested(
    ClientRetweetRequested event,
    ProcessContext context,
  ) async {
    return clientRetweetRequested(event, context);
  }

  Future<FlowResult> toggleUserBlockRequested(
    ClientToggleUserBlockRequested event,
    ProcessContext context,
  ) async {
    return clientToggleUserBlockRequested(event, context);
  }

  Future<FlowResult> toggleCommentLikeRequested(
    ClientToggleCommentLikeRequested event,
    ProcessContext context,
  ) async {
    return clientToggleCommentLikeRequested(event, context);
  }

  Future<FlowResult> createCommentRequested(
    ClientCreateCommentRequested event,
    ProcessContext context,
  ) async {
    return clientCreateCommentRequested(event, context);
  }

  Future<FlowResult> createTweetRequested(
    ClientCreateTweetRequested event,
    ProcessContext context,
  ) async {
    return clientCreateTweetRequested(event, context);
  }

  Future<FlowResult> uploadProfilePictureRequested(
    ClientUploadProfilePictureRequested event,
    ProcessContext context,
  ) async {
    return clientUploadProfilePictureRequested(event, context);
  }

  @override
  void initHandlers(ProcessHandlers handlers) {
    handlers.add<ClientRegisterUserRequested>(
      registerUserRequested,
      ClientRegisterUserRequested.fromJson,
    );
    handlers.add<ClientToggleUserFollowRequested>(
      toggleUserFollowRequested,
      ClientToggleUserFollowRequested.fromJson,
    );
    handlers.add<ClientToggleTweetLikeRequested>(
      toggleTweetLikeRequested,
      ClientToggleTweetLikeRequested.fromJson,
    );
    handlers.add<ClientRetweetRequested>(
      retweetRequested,
      ClientRetweetRequested.fromJson,
    );
    handlers.add<ClientToggleUserBlockRequested>(
      toggleUserBlockRequested,
      ClientToggleUserBlockRequested.fromJson,
    );
    handlers.add<ClientToggleCommentLikeRequested>(
      toggleCommentLikeRequested,
      ClientToggleCommentLikeRequested.fromJson,
    );
    handlers.add<ClientCreateCommentRequested>(
      createCommentRequested,
      ClientCreateCommentRequested.fromJson,
    );
    handlers.add<ClientCreateTweetRequested>(
      createTweetRequested,
      ClientCreateTweetRequested.fromJson,
    );
    handlers.add<ClientUploadProfilePictureRequested>(
      uploadProfilePictureRequested,
      ClientUploadProfilePictureRequested.fromJson,
    );
  }
}
