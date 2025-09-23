import 'package:horda_server/horda_server.dart';

import '../../../counter_server.dart';
import '../../entities/counter/messages.dart';
import '../messages.dart';

/// {@category Process}
///
/// Handles the business process for freezing a counter.
///
/// Flow:
/// 1. Sends 'FreezeCounter' command to the CounterEntity (fire-and-forget).
/// 2. Completes the process.
Future<FlowResult> clientFreezeCounterRequested(
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
