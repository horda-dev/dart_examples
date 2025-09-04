import 'package:horda_server/horda_server.dart';
import 'package:xid/xid.dart';

import '../entities/counter/messages.dart';
import '../entities/counter_list/messages.dart';
import '../services/validation/messages.dart';

import 'messages.dart';

const kCounterListEntityId = 'globalCounterListEntityId';

class ClientProcesses extends Process {
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
