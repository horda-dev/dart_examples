import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

/// Command to add a tweet to the explore feed.
///
/// {@category Entity Command}
@JsonSerializable()
class AddTweetToExploreFeed extends RemoteCommand {
  AddTweetToExploreFeed(this.tweetId);

  /// ID of the tweet to add to the explore feed
  String tweetId;

  factory AddTweetToExploreFeed.fromJson(Map<String, dynamic> json) {
    return _$AddTweetToExploreFeedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$AddTweetToExploreFeedToJson(this);
  }
}

/// Event indicating a tweet was added to the explore feed.
///
/// {@category Entity Event}
@JsonSerializable()
class TweetAddedToExploreFeed extends RemoteEvent {
  TweetAddedToExploreFeed(this.tweetId);

  /// ID of the tweet added to the explore feed
  String tweetId;

  factory TweetAddedToExploreFeed.fromJson(Map<String, dynamic> json) {
    return _$TweetAddedToExploreFeedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$TweetAddedToExploreFeedToJson(this);
  }
}
