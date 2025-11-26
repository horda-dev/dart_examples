import 'package:horda_server/horda_server.dart';
import 'package:xid/xid.dart';

import '../../counter_server.dart';
import '../entities/counter/messages.dart';
import '../entities/counter_list/messages.dart';
import '../services/validation/messages.dart';

/// Process group for counter lifecycle management.
///
/// Handles the creation and deletion of counter entities. These processes
/// manage the full lifecycle from counter instantiation to removal from
/// the system.
class CounterLifecycleProcesses extends ProcessGroup {
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
  static Future<ProcessResult> createCounterRequested(
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

  /// {@category Process}
  ///
  /// Handles the business process for deleting a counter.
  ///
  /// Flow:
  /// 1. Sends 'DeleteCounter' command to the CounterEntity (fire-and-forget).
  /// 2. Sends 'RemoveCounterFromList' command to the CounterListEntity (fire-and-forget).
  /// 3. Completes the process.
  static Future<ProcessResult> deleteCounterRequested(
    DeleteCounterRequested event,
    ProcessContext context,
  ) async {
    context.sendEntity(
      name: 'CounterEntity',
      id: event.counterId,
      cmd: DeleteCounter(),
    );

    context.sendEntity(
      name: 'CounterListEntity',
      id: kSingletonId,
      cmd: RemoveCounterFromList(counterId: event.counterId),
    );

    return ProcessResult.ok();
  }

  @override
  void registerFuncs(ProcessFuncs funcs) {
    funcs
      ..add<CreateCounterRequested>(
        createCounterRequested,
        CreateCounterRequested.fromJson,
      )
      ..add<DeleteCounterRequested>(
        deleteCounterRequested,
        DeleteCounterRequested.fromJson,
      );
  }
}
