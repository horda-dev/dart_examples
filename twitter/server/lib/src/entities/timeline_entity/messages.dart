import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

/// Creates a timeline for a specific user.
///
/// {@category Entity Command}
@JsonSerializable()
class CreateTimeline extends RemoteCommand {
  CreateTimeline(this.ownerUserId);

  /// ID of the user who owns the timeline
  String ownerUserId;

  factory CreateTimeline.fromJson(Map<String, dynamic> json) {
    return _$CreateTimelineFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CreateTimelineToJson(this);
  }
}

/// Event indicating a timeline was created.
///
/// {@category Entity Event}
@JsonSerializable()
class TimelineCreated extends RemoteEvent {
  TimelineCreated(this.ownerUserId);

  /// ID of the user who owns the timeline
  String ownerUserId;

  factory TimelineCreated.fromJson(Map<String, dynamic> json) {
    return _$TimelineCreatedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$TimelineCreatedToJson(this);
  }
}

/// Command to add a tweet to a timeline.
///
/// {@category Entity Command}
@JsonSerializable()
class AddTweetToTimeline extends RemoteCommand {
  AddTweetToTimeline(this.tweetId);

  /// ID of the tweet to add to the timeline
  String tweetId;

  factory AddTweetToTimeline.fromJson(Map<String, dynamic> json) {
    return _$AddTweetToTimelineFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$AddTweetToTimelineToJson(this);
  }
}

/// Event indicating a tweet was added to a timeline.
///
/// {@category Entity Event}
@JsonSerializable()
class TweetAddedToTimeline extends RemoteEvent {
  TweetAddedToTimeline(this.tweetId);

  /// ID of the tweet added to the timeline
  String tweetId;

  factory TweetAddedToTimeline.fromJson(Map<String, dynamic> json) {
    return _$TweetAddedToTimelineFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$TweetAddedToTimelineToJson(this);
  }
}
