import 'package:horda_server/horda_server.dart';

import '../../../counter_server.dart';
import '../../entities/counter/messages.dart';
import '../../entities/counter_list/messages.dart';

/// {@category Process}
///
/// Handles the business process for deleting a counter.
///
/// Flow:
/// 1. Sends 'DeleteCounter' command to the CounterEntity (fire-and-forget).
/// 2. Sends 'RemoveCounterFromList' command to the CounterListEntity (fire-and-forget).
/// 3. Completes the process.
Future<ProcessResult> clientDeleteCounterRequested(
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
