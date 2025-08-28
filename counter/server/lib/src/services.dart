import 'package:horda_server/horda_server.dart';

class ValidateCounterName extends RemoteCommand {
  final String name;

  ValidateCounterName({required this.name});

  factory ValidateCounterName.fromJson(Map<String, dynamic> json) {
    return ValidateCounterName(
      name: json['name'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

class CounterNameIsValid extends RemoteEvent {
  CounterNameIsValid();

  factory CounterNameIsValid.fromJson(Map<String, dynamic> json) =>
      CounterNameIsValid();

  @override
  Map<String, dynamic> toJson() => {};
}

class CounterNameIsInvalid extends RemoteEvent {
  final String reason;

  CounterNameIsInvalid({required this.reason});

  factory CounterNameIsInvalid.fromJson(Map<String, dynamic> json) {
    return CounterNameIsInvalid(reason: json['reason'] as String);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'reason': reason};
  }
}

class TestService extends Service {
  Future<RemoteEvent> increment(
    ValidateCounterName command,
    ServiceContext context,
  ) async {
    if (command.name.length > 10) {
      return CounterNameIsInvalid(reason: 'Too long');
    }

    return CounterNameIsValid();
  }

  @override
  void initHandlers(ServiceHandlers handlers) {
    handlers.add<ValidateCounterName>(increment, ValidateCounterName.fromJson);
  }
}
