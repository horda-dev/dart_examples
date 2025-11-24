import 'package:horda_server/horda_server.dart';

import 'processes/create_tweet_requested_process.dart';
import 'processes/retweet_requested_process.dart';
import 'processes/toggle_tweet_like_requested_process.dart';
import 'messages.dart';

class TweetProcesses extends ProcessGroup {
  @override
  void registerFuncs(ProcessFuncs funcs) {
    funcs.add<ClientCreateTweetRequested>(
      clientCreateTweetRequested,
      ClientCreateTweetRequested.fromJson,
    );
    funcs.add<ClientRetweetRequested>(
      clientRetweetRequested,
      ClientRetweetRequested.fromJson,
    );
    funcs.add<ClientToggleTweetLikeRequested>(
      clientToggleTweetLikeRequested,
      ClientToggleTweetLikeRequested.fromJson,
    );
  }
}
