import 'package:horda_server/horda_server.dart';
import 'package:xid/xid.dart';

import '../entities/counter/messages.dart';
import '../entities/counter_list/messages.dart';
import '../services/validation/messages.dart';

import 'messages.dart';

/// The global entity ID used for the shared counter list.
/// 
/// This constant defines the single instance ID for the counter list entity
/// that manages all counters in the system.
const kCounterListEntityId = 'globalCounterListEntityId';

/// Process handler for client-initiated counter operations.
/// 
/// This class orchestrates counter-related workflows by coordinating between
/// entities and services. It handles counter creation, deletion, modification,
/// and list management operations initiated by clients.
class ClientProcesses extends Process {
  /// Creates a new counter with validation and adds it to the global list.
  /// 
  /// This process:
  /// 1. Generates a unique counter ID
  /// 2. Validates the counter name using ValidationService
  /// 3. Creates the counter entity if validation passes
  /// 4. Adds the counter to the global counter list
  /// 
  /// [event] contains the counter name and initial value
  /// [context] provides the process execution context
  /// 
  /// Returns a [FlowResult] with the new counter ID on success,
  /// or an error if validation fails.
  Future<FlowResult> create(
    CreateCounterRequested event,
    ProcessContext context,
  ) async {
    // generate counter id
    final newCounterId = Xid().toString();

    // validate counter name
    final validationResult = await context.callService<CounterNameValidated>(
      name: 'ValidationService',
      cmd: ValidateCounterName(name: event.name),
      fac: CounterNameValidated.fromJson,
    );

    // if name is invalid finish the process with an error
    if (!validationResult.isValid) {
      return FlowResult.error('counter name is invalid');
    }

    // create counter entity
    await context.callEntity<CounterCreated>(
      name: 'CounterEntity',
      id: newCounterId,
      cmd: CreateCounter(name: event.name, initialValue: event.initialValue),
      fac: CounterCreated.fromJson,
    );

    // add the counter to the list
    await context.callEntity<CounterAddedToList>(
      name: 'CounterListEntity',
      id: kCounterListEntityId,
      cmd: AddCounterToList(counterId: newCounterId),
      fac: CounterAddedToList.fromJson,
    );

    return FlowResult.ok(newCounterId);
  }

  /// Deletes a counter and removes it from the global list.
  /// 
  /// This process:
  /// 1. Sends a delete command to the counter entity
  /// 2. Removes the counter from the global counter list
  /// 
  /// Both operations are fire-and-forget for performance.
  /// 
  /// [event] contains the ID of the counter to delete
  /// [context] provides the process execution context
  /// 
  /// Returns a successful [FlowResult].
  Future<FlowResult> delete(
    DeleteCounterRequested event,
    ProcessContext context,
  ) async {
    // delete entity (don't wait for a resulting event)
    context.sendEntity(
      name: 'CounterEntity',
      id: event.counterId,
      cmd: DeleteCounter(),
    );

    // delete counter from the list (don't wait for a resulting event)
    context.sendEntity(
      name: 'CounterListEntity',
      id: kCounterListEntityId,
      cmd: RemoveCounterFromList(counterId: event.counterId),
    );

    return FlowResult.ok();
  }

  /// Increments a counter by the specified amount.
  /// 
  /// Sends an increment command to the target counter entity.
  /// This is a fire-and-forget operation for performance.
  /// 
  /// [event] contains the counter ID and increment amount
  /// [context] provides the process execution context
  /// 
  /// Returns a successful [FlowResult].
  Future<FlowResult> increment(
    IncrementCounterRequested event,
    ProcessContext context,
  ) async {
    context.sendEntity(
      name: 'CounterEntity',
      id: event.counterId,
      cmd: IncrementCounter(amount: event.amount),
    );
    return FlowResult.ok();
  }

  /// Decrements a counter by the specified amount.
  /// 
  /// Sends a decrement command to the target counter entity.
  /// This is a fire-and-forget operation for performance.
  /// 
  /// [event] contains the counter ID and decrement amount
  /// [context] provides the process execution context
  /// 
  /// Returns a successful [FlowResult].
  Future<FlowResult> decrement(
    DecrementCounterRequested event,
    ProcessContext context,
  ) async {
    context.sendEntity(
      name: 'CounterEntity',
      id: event.counterId,
      cmd: DecrementCounter(amount: event.amount),
    );
    return FlowResult.ok();
  }

  /// Freezes a counter to prevent modifications.
  /// 
  /// Sends a freeze command to the target counter entity.
  /// This is a fire-and-forget operation for performance.
  /// 
  /// [event] contains the counter ID to freeze
  /// [context] provides the process execution context
  /// 
  /// Returns a successful [FlowResult].
  Future<FlowResult> freeze(
    FreezeCounterRequested event,
    ProcessContext context,
  ) async {
    context.sendEntity(
      name: 'CounterEntity',
      id: event.counterId,
      cmd: FreezeCounter(),
    );
    return FlowResult.ok();
  }

  /// Unfreezes a counter to allow modifications.
  /// 
  /// Sends an unfreeze command to the target counter entity.
  /// This is a fire-and-forget operation for performance.
  /// 
  /// [event] contains the counter ID to unfreeze
  /// [context] provides the process execution context
  /// 
  /// Returns a successful [FlowResult].
  Future<FlowResult> unfreeze(
    UnfreezeCounterRequested event,
    ProcessContext context,
  ) async {
    context.sendEntity(
      name: 'CounterEntity',
      id: event.counterId,
      cmd: UnfreezeCounter(),
    );
    return FlowResult.ok();
  }

  /// Creates the global counter list entity.
  /// 
  /// Initializes the shared counter list that manages all counters in the system.
  /// This should typically be called once during system initialization.
  /// 
  /// [event] the creation request
  /// [context] provides the process execution context
  /// 
  /// Returns a [FlowResult] with the counter list entity ID on success.
  Future<FlowResult> createList(
    CreateCounterListRequested event,
    ProcessContext context,
  ) async {
    await context.callEntity<CounterListCreated>(
      name: 'CounterListEntity',
      id: kCounterListEntityId,
      cmd: CreateCounterList(),
      fac: CounterListCreated.fromJson,
    );

    return FlowResult.ok(kCounterListEntityId);
  }

  @override
  void initHandlers(ProcessHandlers handlers) {
    handlers
      ..add<CreateCounterRequested>(create, CreateCounterRequested.fromJson)
      ..add<DeleteCounterRequested>(delete, DeleteCounterRequested.fromJson)
      ..add<IncrementCounterRequested>(
        increment,
        IncrementCounterRequested.fromJson,
      )
      ..add<DecrementCounterRequested>(
        decrement,
        DecrementCounterRequested.fromJson,
      )
      ..add<FreezeCounterRequested>(freeze, FreezeCounterRequested.fromJson)
      ..add<UnfreezeCounterRequested>(
        unfreeze,
        UnfreezeCounterRequested.fromJson,
      )
      ..add<CreateCounterListRequested>(
        createList,
        CreateCounterListRequested.fromJson,
      );
  }
}
