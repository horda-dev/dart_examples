import 'package:horda_server/horda_server.dart';

import '../entities/counter_list/entity.dart';
import '../messages.dart';

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
