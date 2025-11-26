import 'package:horda_server/horda_server.dart';

import '../../counter_server.dart';
import '../entities/counter/messages.dart';

/// Process group for counter operations on existing counters.
///
/// Handles value modifications (increment/decrement) and state changes
/// (freeze/unfreeze) for counters. These processes operate on counters
/// that have already been created.
class CounterOperationProcesses extends ProcessGroup {
  /// {@category Process}
  ///
  /// Handles the business process for incrementing a counter.
  ///
  /// Flow:
  /// 1. Sends 'IncrementCounter' command to the CounterEntity (fire-and-forget).
  /// 2. Completes the process.
  static Future<ProcessResult> incrementCounterRequested(
    IncrementCounterRequested event,
    ProcessContext context,
  ) async {
    context.sendEntity(
      name: 'CounterEntity',
      id: event.counterId,
      cmd: IncrementCounter(amount: event.amount),
    );
    return ProcessResult.ok();
  }

  /// {@category Process}
  ///
  /// Handles the business process for decrementing a counter.
  ///
  /// Flow:
  /// 1. Sends 'DecrementCounter' command to the CounterEntity (fire-and-forget).
  /// 2. Completes the process.
  static Future<ProcessResult> decrementCounterRequested(
    DecrementCounterRequested event,
    ProcessContext context,
  ) async {
    context.sendEntity(
      name: 'CounterEntity',
      id: event.counterId,
      cmd: DecrementCounter(amount: event.amount),
    );
    return ProcessResult.ok();
  }

  /// {@category Process}
  ///
  /// Handles the business process for freezing a counter.
  ///
  /// Flow:
  /// 1. Sends 'FreezeCounter' command to the CounterEntity (fire-and-forget).
  /// 2. Completes the process.
  static Future<ProcessResult> freezeCounterRequested(
    FreezeCounterRequested event,
    ProcessContext context,
  ) async {
    context.sendEntity(
      name: 'CounterEntity',
      id: event.counterId,
      cmd: FreezeCounter(),
    );
    return ProcessResult.ok();
  }

  /// {@category Process}
  ///
  /// Handles the business process for unfreezing a counter.
  ///
  /// Flow:
  /// 1. Sends 'UnfreezeCounter' command to the CounterEntity (fire-and-forget).
  /// 2. Completes the process.
  static Future<ProcessResult> unfreezeCounterRequested(
    UnfreezeCounterRequested event,
    ProcessContext context,
  ) async {
    context.sendEntity(
      name: 'CounterEntity',
      id: event.counterId,
      cmd: UnfreezeCounter(),
    );
    return ProcessResult.ok();
  }

  @override
  void registerFuncs(ProcessFuncs funcs) {
    funcs
      ..add<IncrementCounterRequested>(
        incrementCounterRequested,
        IncrementCounterRequested.fromJson,
      )
      ..add<DecrementCounterRequested>(
        decrementCounterRequested,
        DecrementCounterRequested.fromJson,
      )
      ..add<FreezeCounterRequested>(
        freezeCounterRequested,
        FreezeCounterRequested.fromJson,
      )
      ..add<UnfreezeCounterRequested>(
        unfreezeCounterRequested,
        UnfreezeCounterRequested.fromJson,
      );
  }
}
