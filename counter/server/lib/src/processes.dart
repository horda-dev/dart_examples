import 'package:horda_server/horda_server.dart';
import 'package:xid/xid.dart';

import 'messages.dart';

final kCounterListEntityId = 'globalCounterListEntityId';

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
    print('Processing message: ${event.counterId}');

    return FlowResult.ok();
  }

  Future<FlowResult> increment(
    IncrementCounterRequested event,
    ProcessContext context,
  ) async {
    print('Processing message: ${event.counterId}');

    return FlowResult.ok();
  }

  Future<FlowResult> decrement(
    DecrementCounterRequested event,
    ProcessContext context,
  ) async {
    print('Processing message: ${event.counterId}');

    return FlowResult.ok();
  }

  Future<FlowResult> freeze(
    FreezeCounterRequested event,
    ProcessContext context,
  ) async {
    print('Processing message: ${event.counterId}');

    return FlowResult.ok();
  }

  Future<FlowResult> unfreeze(
    UnfreezeCounterRequested event,
    ProcessContext context,
  ) async {
    print('Processing message: ${event.counterId}');

    return FlowResult.ok();
  }

  @override
  void initHandlers(ProcessHandlers handlers) {
    handlers.add<CreateCounterRequested>(
      create,
      CreateCounterRequested.fromJson,
    );
    handlers.add<DeleteCounterRequested>(
      delete,
      DeleteCounterRequested.fromJson,
    );
    handlers.add<IncrementCounterRequested>(
      increment,
      IncrementCounterRequested.fromJson,
    );
    handlers.add<DecrementCounterRequested>(
      decrement,
      DecrementCounterRequested.fromJson,
    );
    handlers.add<FreezeCounterRequested>(
      freeze,
      FreezeCounterRequested.fromJson,
    );
    handlers.add<UnfreezeCounterRequested>(
      unfreeze,
      UnfreezeCounterRequested.fromJson,
    );
  }
}
