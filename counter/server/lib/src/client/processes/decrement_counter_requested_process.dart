import 'package:horda_server/horda_server.dart';

import '../../../counter_server.dart';
import '../../entities/counter/messages.dart';
import '../messages.dart';

/// {@category Process}
///
/// Handles the business process for decrementing a counter.
///
/// Flow:
/// 1. Sends 'DecrementCounter' command to the CounterEntity (fire-and-forget).
/// 2. Completes the process.
Future<FlowResult> clientDecrementCounterRequested(
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
