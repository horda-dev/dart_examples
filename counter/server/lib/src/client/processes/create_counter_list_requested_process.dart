import 'package:horda_server/horda_server.dart';

import '../../../counter_server.dart';
import '../../entities/counter_list/messages.dart';

/// {@category Process}
///
/// Handles the business process for creating the global counter list entity.
///
/// Flow:
/// 1. Sends 'CreateCounterList' command to the CounterListEntity.
/// 2. Waits for 'CounterListCreated' event.
/// 3. Completes the process, returning the ID of the created list.
Future<FlowResult> clientCreateCounterListRequested(
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
