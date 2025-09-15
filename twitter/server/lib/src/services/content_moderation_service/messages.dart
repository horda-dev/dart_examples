import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

/// Validates text content for inappropriate material.
///
/// {@category Service Command}
@JsonSerializable()
class ModerateText extends RemoteCommand {
  ModerateText(this.text, this.userId);

  /// text content to moderate
  String text;

  /// ID of the user sending the content
  String userId;

  factory ModerateText.fromJson(Map<String, dynamic> json) {
    return _$ModerateTextFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ModerateTextToJson(this);
  }
}

/// Text moderation process completed.
///
/// {@category Service Event}
@JsonSerializable()
class TextModerationCompleted extends RemoteEvent {
  TextModerationCompleted(this.isValid, this.reason, this.originalText);

  /// whether text passed moderation
  bool isValid;

  /// reason for rejection if invalid
  String reason;

  /// original text that was moderated
  String originalText;

  factory TextModerationCompleted.fromJson(Map<String, dynamic> json) {
    return _$TextModerationCompletedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$TextModerationCompletedToJson(this);
  }
}
