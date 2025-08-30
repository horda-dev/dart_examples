import 'package:counter_server/src/entities.dart';
import 'package:horda_server/horda_server.dart';
import 'package:xid/xid.dart';

import 'messages.dart';

final kCounterListEntityId = 'globalCounterListEntityId';

class CounterListProcesses extends Process {
  Future<FlowResult> createList(
    CreateCounterListRequested event,
    ProcessContext context,
  ) async {
    await context.callEntity<CounterListCreatedEvent>(
      name: 'CounterListEntity',
      id: kCounterListEntityId,
      cmd: CreateCounterListCommand(),
      fac: CounterListCreatedEvent.fromJson,
    );

    return FlowResult.ok(kCounterListEntityId);
  }

  @override
  void initHandlers(ProcessHandlers handlers) {
    handlers.add<CreateCounterListRequested>(
      createList,
      CreateCounterListRequested.fromJson,
    );
  }
}

class CounterProcesses extends Process {
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
    if (validationResult.isValid) {
      return FlowResult.error('counter name is invalid');
    }

    // create counter entity
    await context.callEntity<CounterCreatedEvent>(
      name: 'CounterEntity',
      id: newCounterId,
      cmd: CreateCounterCommand(
        name: event.name,
        initialValue: event.initialValue,
      ),
      fac: CounterCreatedEvent.fromJson,
    );

    // add the counter to the list
    await context.callEntity<CounterAddedToListEvent>(
      name: 'CounterListEntity',
      id: kCounterListEntityId,
      cmd: AddCounterToListCommand(counterId: newCounterId),
      fac: CounterAddedToListEvent.fromJson,
    );

    return FlowResult.ok(newCounterId);
  }

  Future<FlowResult> delete(
    DeleteCounterRequested event,
    ProcessContext context,
  ) async {
    // delete entity (don't wait for a resulting event)
    context.sendEntity(
      name: 'CounterEntity',
      id: event.counterId,
      cmd: DeleteCounterCommand(),
    );

    // delete counter from the list (don't wait for a resulting event)
    context.sendEntity(
      name: 'CounterEntityEntity',
      id: kCounterListEntityId,
      cmd: RemoveCounterFromListCommand(counterId: event.counterId),
    );

    return FlowResult.ok();
  }

  Future<FlowResult> increment(
    IncrementCounterRequested event,
    ProcessContext context,
  ) async {
    try {
      // increment counter (don't wait for a resulting event)
      context.sendEntity(
        name: 'CounterEntity',
        id: event.counterId,
        cmd: IncrementCounterCommand(amount: event.amount),
      );
    } on CounterEntityException catch (e) {
      return FlowResult.error(e.message);
    }

    return FlowResult.ok();
  }

  Future<FlowResult> decrement(
    DecrementCounterRequested event,
    ProcessContext context,
  ) async {
    try {
      // decrement counter (don't wait for a resulting event)
      context.sendEntity(
        name: 'CounterEntity',
        id: event.counterId,
        cmd: DecrementCounterCommand(amount: event.amount),
      );
    } on CounterEntityException catch (e) {
      return FlowResult.error(e.message);
    }

    return FlowResult.ok();
  }

  Future<FlowResult> freeze(
    FreezeCounterRequested event,
    ProcessContext context,
  ) async {
    try {
      // freeze counter (don't wait for a resulting event)
      context.sendEntity(
        name: 'CounterEntity',
        id: event.counterId,
        cmd: FreezeCounterCommand(),
      );
    } on CounterEntityException catch (e) {
      return FlowResult.error(e.message);
    }

    return FlowResult.ok();
  }

  Future<FlowResult> unfreeze(
    UnfreezeCounterRequested event,
    ProcessContext context,
  ) async {
    try {
      // unfreeze counter (don't wait for a resulting event)
      context.sendEntity(
        name: 'CounterEntity',
        id: event.counterId,
        cmd: UnfreezeCounterCommand(),
      );
    } on CounterEntityException catch (e) {
      return FlowResult.error(e.message);
    }

    return FlowResult.ok();
  }

  @override
  void initHandlers(ProcessHandlers handlers) {
    handlers
      ..add<CreateCounterRequested>(
        create,
        CreateCounterRequested.fromJson,
      )
      ..add<DeleteCounterRequested>(
        delete,
        DeleteCounterRequested.fromJson,
      )
      ..add<IncrementCounterRequested>(
        increment,
        IncrementCounterRequested.fromJson,
      )
      ..add<DecrementCounterRequested>(
        decrement,
        DecrementCounterRequested.fromJson,
      )
      ..add<FreezeCounterRequested>(
        freeze,
        FreezeCounterRequested.fromJson,
      )
      ..add<UnfreezeCounterRequested>(
        unfreeze,
        UnfreezeCounterRequested.fromJson,
      );
  }
}
