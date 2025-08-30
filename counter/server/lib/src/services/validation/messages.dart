import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

@JsonSerializable()
class ValidateCounterName extends RemoteCommand {
  final String name;

  ValidateCounterName({required this.name});

  factory ValidateCounterName.fromJson(Map<String, dynamic> json) =>
      _$ValidateCounterNameFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ValidateCounterNameToJson(this);
}

@JsonSerializable()
class CounterNameValidated extends RemoteEvent {
  final bool isValid;
  final String invalidReason;

  CounterNameValidated.valid() : isValid = true, invalidReason = '';

  CounterNameValidated.invalid({required this.invalidReason}) : isValid = false;

  CounterNameValidated({required this.isValid, required this.invalidReason});

  factory CounterNameValidated.fromJson(Map<String, dynamic> json) =>
      _$CounterNameValidatedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterNameValidatedToJson(this);
}
