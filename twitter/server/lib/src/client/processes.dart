import 'package:horda_server/horda_server.dart';
import 'processes/register_user_requested_process.dart';
import 'processes/log_in_user_requested_process.dart';
import 'processes/toggle_user_follow_requested_process.dart';
import 'processes/toggle_tweet_like_requested_process.dart';
import 'processes/retweet_requested_process.dart';
import 'processes/block_user_requested_process.dart';
import 'processes/toggle_comment_like_requested_process.dart';
import 'processes/create_comment_requested_process.dart';

class ClientProcess extends Process {
  Future<FlowResult> registerUserRequested(
    ClientRegisterUserRequested event,
    ProcessContext context,
  ) async {
    return clientRegisterUserRequested(event, context);
  }

  Future<FlowResult> logInUserRequested(
    ClientLogInUserRequested event,
    ProcessContext context,
  ) async {
    return clientLogInUserRequested(event, context);
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

  Future<FlowResult> blockUserRequested(
    ClientBlockUserRequested event,
    ProcessContext context,
  ) async {
    return clientBlockUserRequested(event, context);
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

  @override
  void initHandlers(ProcessHandlers handlers) {
    handlers.add<ClientRegisterUserRequested>(
      registerUserRequested,
      ClientRegisterUserRequested.fromJson,
    );
    handlers.add<ClientLogInUserRequested>(
      logInUserRequested,
      ClientLogInUserRequested.fromJson,
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
    handlers.add<ClientBlockUserRequested>(
      blockUserRequested,
      ClientBlockUserRequested.fromJson,
    );
    handlers.add<ClientToggleCommentLikeRequested>(
      toggleCommentLikeRequested,
      ClientToggleCommentLikeRequested.fromJson,
    );
    handlers.add<ClientCreateCommentRequested>(
      createCommentRequested,
      ClientCreateCommentRequested.fromJson,
    );
  }
}
