import 'package:horda_server/horda_server.dart';
import 'package:xid/xid.dart';

import '../../../counter_server.dart';
import '../../entities/counter/messages.dart';
import '../../entities/counter_list/messages.dart';
import '../../services/validation/messages.dart';

/// {@category Process}
///
/// Handles the business process for creating a new counter.
///
/// Flow:
/// 1. Generates a unique counter ID.
/// 2. Validates the counter name using ValidationService.
/// 3. Returns error if validation fails.
/// 4. Sends 'CreateCounter' command to the CounterEntity.
/// 5. Waits for 'CounterCreated' event.
/// 6. Sends 'AddCounterToList' command to the CounterListEntity.
/// 7. Waits for 'CounterAddedToList' event.
/// 8. Completes the process, returning the new counter ID.
Future<ProcessResult> clientCreateCounterRequested(
  CreateCounterRequested event,
  ProcessContext context,
) async {
  final newCounterId = Xid().toString();

  final validationResult = await context.callService<CounterNameValidated>(
    name: 'ValidationService',
    cmd: ValidateCounterName(name: event.name),
    fac: CounterNameValidated.fromJson,
  );

  if (!validationResult.isValid) {
    return ProcessResult.error('counter name is invalid');
  }

  await context.callEntity<CounterCreated>(
    name: 'CounterEntity',
    id: newCounterId,
    cmd: CreateCounter(name: event.name, initialValue: event.initialValue),
    fac: CounterCreated.fromJson,
  );

  await context.callEntity<CounterAddedToList>(
    name: 'CounterListEntity',
    id: kSingletonId,
    cmd: AddCounterToList(counterId: newCounterId),
    fac: CounterAddedToList.fromJson,
  );

  return ProcessResult.ok(newCounterId);
}
