import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

/// Command to validate a counter name according to business rules.
///
/// This command is sent to the ValidationService to check if a proposed
/// counter name meets the system's validation criteria.
///
/// {@category Service Command}
@JsonSerializable()
class ValidateCounterName extends RemoteCommand {
  /// The counter name to validate.
  final String name;

  /// Creates a new counter name validation command.
  ///
  /// [name] is the proposed counter name to be validated.
  ValidateCounterName({required this.name});

  factory ValidateCounterName.fromJson(Map<String, dynamic> json) =>
      _$ValidateCounterNameFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ValidateCounterNameToJson(this);
}

/// Event indicating the result of counter name validation.
///
/// This event is returned by the ValidationService to indicate whether
/// a proposed counter name is valid according to business rules.
///
/// {@category Service Event}
@JsonSerializable()
class CounterNameValidated extends RemoteEvent {
  /// Whether the counter name passed validation.
  final bool isValid;

  /// The reason for validation failure (empty if valid).
  final String invalidReason;

  /// Creates a validation result indicating the name is valid.
  CounterNameValidated.valid() : isValid = true, invalidReason = '';

  /// Creates a validation result indicating the name is invalid.
  ///
  /// [invalidReason] describes why the validation failed.
  CounterNameValidated.invalid({required this.invalidReason}) : isValid = false;

  /// Creates a validation result with explicit values.
  ///
  /// [isValid] indicates if validation passed
  /// [invalidReason] describes the failure reason (should be empty if valid)
  CounterNameValidated({required this.isValid, required this.invalidReason});

  factory CounterNameValidated.fromJson(Map<String, dynamic> json) =>
      _$CounterNameValidatedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterNameValidatedToJson(this);
}
