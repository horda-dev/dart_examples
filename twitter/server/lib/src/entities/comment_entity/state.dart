import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

import 'entity.dart';
import 'messages.dart';

part 'state.g.dart';

/// State of [CommentEntity].
///
/// {@category Entity State}
@JsonSerializable(constructor: '_json')
class CommentEntityState implements EntityState {
  CommentEntityState._json(this._likedByUsers);

  /// List of user IDs who liked the comment
  List<String> get likedByUsers => _likedByUsers;

  /// List of user IDs who liked the comment
  @JsonKey(name: 'likedByUsers', includeToJson: true, includeFromJson: true)
  List<String> _likedByUsers;

  @override
  void project(RemoteEvent event) {
    return switch (event) {
      _ => null,
    };
  }

  factory CommentEntityState.fromJson(Map<String, dynamic> json) {
    return _$CommentEntityStateFromJson(json);
  }
  @override
  Map<String, dynamic> toJson() {
    return _$CommentEntityStateToJson(this);
  }
}
