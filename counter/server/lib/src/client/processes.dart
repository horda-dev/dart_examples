import 'package:horda_server/horda_server.dart';

import 'messages.dart';
import 'processes/create_counter_list_requested_process.dart';
import 'processes/create_counter_requested_process.dart';
import 'processes/decrement_counter_requested_process.dart';
import 'processes/delete_counter_requested_process.dart';
import 'processes/freeze_counter_requested_process.dart';
import 'processes/increment_counter_requested_process.dart';
import 'processes/unfreeze_counter_requested_process.dart';

/// The global entity ID used for the shared counter list.
///
/// This constant defines the single instance ID for the counter list entity
/// that manages all counters in the system.
const kCounterListEntityId = 'globalCounterListEntityId';

/// Process handler for client-initiated counter operations.
///
/// This class orchestrates counter-related workflows by coordinating between
/// entities and services. It handles counter creation, deletion, modification,
/// and list management operations initiated by clients.
class ClientProcesses extends Process {
  @override
  void initHandlers(ProcessHandlers handlers) {
    handlers
      ..add<CreateCounterRequested>(
        clientCreateCounterRequested,
        CreateCounterRequested.fromJson,
      )
      ..add<DeleteCounterRequested>(
        clientDeleteCounterRequested,
        DeleteCounterRequested.fromJson,
      )
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
      )
      ..add<CreateCounterListRequested>(
        clientCreateCounterListRequested,
        CreateCounterListRequested.fromJson,
      );
  }
}
