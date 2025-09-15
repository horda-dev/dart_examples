import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

import 'entity.dart';
import 'messages.dart';

part 'state.g.dart';

/// State of [TweetEntity].
///
/// {@category Entity State}
@JsonSerializable(constructor: '_json')
class TweetEntityState implements EntityState {
  TweetEntityState._json(this._retweetedByUsers, this._likedByUsers);

  /// List of user IDs who retweeted the tweet
  List<String> get retweetedByUsers => _retweetedByUsers;

  /// List of user IDs who retweeted the tweet
  @JsonKey(name: 'retweetedByUsers', includeToJson: true, includeFromJson: true)
  List<String> _retweetedByUsers;

  /// List of user IDs who liked the tweet
  List<String> get likedByUsers => _likedByUsers;

  /// List of user IDs who liked the tweet
  @JsonKey(name: 'likedByUsers', includeToJson: true, includeFromJson: true)
  List<String> _likedByUsers;

  @override
  void project(RemoteEvent event) {
    return switch (event) {
      _ => null,
    };
  }

  factory TweetEntityState.fromJson(Map<String, dynamic> json) {
    return _$TweetEntityStateFromJson(json);
  }
  @override
  Map<String, dynamic> toJson() {
    return _$TweetEntityStateToJson(this);
  }
}
