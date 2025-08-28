import 'package:horda_server/horda_server.dart';

import 'messages.dart';

class CounterProcesses extends Process {
  Future<FlowResult> create(
    CreateCounterRequested event,
    ProcessContext context,
  ) async {
    print('Processing message: ${event.name}');

    return FlowResult.ok();
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
  }
}
