import 'package:horda_server/horda_server.dart';

import 'messages.dart';

class ValidationService extends Service {
  Future<RemoteEvent> validate(
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
    handlers.add<ValidateCounterName>(validate, ValidateCounterName.fromJson);
  }
}
