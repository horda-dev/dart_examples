import 'package:horda_server/horda_server.dart';

import '../../../counter_server.dart';
import '../../entities/counter/messages.dart';
import '../messages.dart';

/// {@category Process}
///
/// Handles the business process for incrementing a counter.
///
/// Flow:
/// 1. Sends 'IncrementCounter' command to the CounterEntity (fire-and-forget).
/// 2. Completes the process.
Future<FlowResult> clientIncrementCounterRequested(
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
