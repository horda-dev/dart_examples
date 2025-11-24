import 'package:horda_server/horda_server.dart';

import 'messages.dart';
import 'processes/create_counter_requested_process.dart';
import 'processes/decrement_counter_requested_process.dart';
import 'processes/delete_counter_requested_process.dart';
import 'processes/freeze_counter_requested_process.dart';
import 'processes/increment_counter_requested_process.dart';
import 'processes/unfreeze_counter_requested_process.dart';

// Process groups organizig business processes into logical units.
//
// A ProcessGroup is a collection of related process functions that respond to
// client requests. Each process function implements business logic by coordinating
// between entities, services, and other system components.

/// Process group for counter lifecycle management.
///
/// Handles the creation and deletion of counter entities. These processes
/// manage the full lifecycle from counter instantiation to removal from
/// the system.
class CounterLifecycleProcesses extends ProcessGroup {
  @override
  void registerFuncs(ProcessFuncs funcs) {
    funcs
      ..add<CreateCounterRequested>(
        clientCreateCounterRequested,
        CreateCounterRequested.fromJson,
      )
      ..add<DeleteCounterRequested>(
        clientDeleteCounterRequested,
        DeleteCounterRequested.fromJson,
      );
  }
}

/// Process group for counter operations on existing counters.
///
/// Handles value modifications (increment/decrement) and state changes
/// (freeze/unfreeze) for counters. These processes operate on counters
/// that have already been created.
class CounterOperationProcesses extends ProcessGroup {
  @override
  void registerFuncs(ProcessFuncs funcs) {
    funcs
      ..add<IncrementCounterRequested>(
        clientIncrementCounterRequested,
        IncrementCounterRequested.fromJson,
      )
      ..add<DecrementCounterRequested>(
        clientDecrementCounterRequested,
        DecrementCounterRequested.fromJson,
      )
      ..add<FreezeCounterRequested>(
        clientFreezeCounterRequested,
        FreezeCounterRequested.fromJson,
      )
      ..add<UnfreezeCounterRequested>(
        clientUnfreezeCounterRequested,
        UnfreezeCounterRequested.fromJson,
      );
  }
}
