import 'package:horda_server/horda_server.dart';

import 'messages.dart';

class ValidationService extends Service {
  Future<RemoteEvent> validate(
    ValidateCounterName command,
    ServiceContext context,
  ) async {
    if (command.name.length > 10) {
      return CounterNameValidated.invalid(invalidReason: 'too long');
    }

    return CounterNameValidated.valid();
  }

  @override
  void initHandlers(ServiceHandlers handlers) {
    handlers.add<ValidateCounterName>(validate, ValidateCounterName.fromJson);
  }
}
