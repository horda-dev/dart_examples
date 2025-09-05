import 'package:horda_server/horda_server.dart';

import 'messages.dart';

/// Service for validating counter-related data and business rules.
///
/// This service provides validation logic for counter operations,
/// ensuring data integrity and business rule compliance before
/// entity operations are performed.
class ValidationService extends Service {
  /// Validates a counter name according to business rules.
  ///
  /// Currently enforces a maximum length of 10 characters for counter names.
  /// Additional validation rules can be added here as needed.
  ///
  /// [command] contains the counter name to validate
  /// [context] provides the service execution context
  ///
  /// Returns a [CounterNameValidated] event indicating validation result.
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
