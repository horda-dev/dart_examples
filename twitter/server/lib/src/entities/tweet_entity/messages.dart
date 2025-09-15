import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

/// Creates a new tweet with author user ID and text content.
///
/// {@category Entity Command}
@JsonSerializable()
class CreateTweet extends RemoteCommand {
  CreateTweet(this.authorUserId, this.text);

  /// ID of the user who authored the tweet
  String authorUserId;

  /// Text content of the tweet
  String text;

  factory CreateTweet.fromJson(Map<String, dynamic> json) {
    return _$CreateTweetFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CreateTweetToJson(this);
  }
}

/// Event indicating a tweet was created.
///
/// {@category Entity Event}
@JsonSerializable()
class TweetCreated extends RemoteEvent {
  TweetCreated(this.authorUserId, this.text);

  /// ID of the user who authored the tweet
  String authorUserId;

  /// Text content of the tweet
  String text;

  factory TweetCreated.fromJson(Map<String, dynamic> json) {
    return _$TweetCreatedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$TweetCreatedToJson(this);
  }
}

/// {@category Entity Command}
@JsonSerializable()
class ToggleTweetLike extends RemoteCommand {
  ToggleTweetLike(this.userId);

  /// ID of the user toggling like status on the tweet
  String userId;

  factory ToggleTweetLike.fromJson(Map<String, dynamic> json) {
    return _$ToggleTweetLikeFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ToggleTweetLikeToJson(this);
  }
}

/// {@category Entity Event}
@JsonSerializable()
class TweetLiked extends RemoteEvent {
  TweetLiked(this.userId);

  /// ID of the user who liked the tweet
  String userId;

  factory TweetLiked.fromJson(Map<String, dynamic> json) {
    return _$TweetLikedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$TweetLikedToJson(this);
  }
}

/// {@category Entity Event}
@JsonSerializable()
class TweetUnliked extends RemoteEvent {
  TweetUnliked(this.userId);

  /// ID of the user who unliked the tweet
  String userId;

  factory TweetUnliked.fromJson(Map<String, dynamic> json) {
    return _$TweetUnlikedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$TweetUnlikedToJson(this);
  }
}

/// Command to retweet a tweet.
///
/// {@category Entity Command}
@JsonSerializable()
class RetweetTweet extends RemoteCommand {
  RetweetTweet(this.userId);

  /// ID of the user who retweets the tweet
  String userId;

  factory RetweetTweet.fromJson(Map<String, dynamic> json) {
    return _$RetweetTweetFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$RetweetTweetToJson(this);
  }
}

/// Event indicating a tweet was retweeted.
///
/// {@category Entity Event}
@JsonSerializable()
class TweetRetweeted extends RemoteEvent {
  TweetRetweeted(this.userId);

  /// ID of the user who retweeted the tweet
  String userId;

  factory TweetRetweeted.fromJson(Map<String, dynamic> json) {
    return _$TweetRetweetedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$TweetRetweetedToJson(this);
  }
}

/// Command to add a comment to a tweet.
///
/// {@category Entity Command}
@JsonSerializable()
class AddTweetComment extends RemoteCommand {
  AddTweetComment(this.commentId);

  /// ID of the comment to add to the tweet
  String commentId;

  factory AddTweetComment.fromJson(Map<String, dynamic> json) {
    return _$AddTweetCommentFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$AddTweetCommentToJson(this);
  }
}

/// Event indicating a comment was added to a tweet.
///
/// {@category Entity Event}
@JsonSerializable()
class TweetCommentAdded extends RemoteEvent {
  TweetCommentAdded(this.commentId);

  /// ID of the comment added to the tweet
  String commentId;

  factory TweetCommentAdded.fromJson(Map<String, dynamic> json) {
    return _$TweetCommentAddedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$TweetCommentAddedToJson(this);
  }
}
