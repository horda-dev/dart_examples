import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';
import 'package:counter_server/counter_server.dart';

import 'query.dart';

class CounterDetailsViewModel {
  CounterDetailsViewModel(this.context, this.itemKey);

  final BuildContext context;

  final String itemKey;

  String get id {
    return context.query<CounterQuery>().id();
  }

  String get name {
    return context.query<CounterQuery>().value((q) => q.counterName);
  }

  int get value {
    return context.query<CounterQuery>().counter((q) => q.counterValue);
  }

  String get status {
    return context.query<CounterQuery>().value((q) => q.freezeStatus);
  }

  bool get isFrozen {
    return status == 'frozen';
  }

  Future<void> delete() async {
    final res = await context.runProcess(
      DeleteCounterRequested(counterKey: itemKey),
    );
    if (res.isError) {
      throw CounterDetailsException(res.value ?? '');
    }
  }

  Future<void> increment() async {
    await context.runProcess(
      IncrementCounterRequested(counterId: id, amount: 1),
    );
  }

  Future<void> decrement() async {
    await context.runProcess(
      DecrementCounterRequested(counterId: id, amount: 1),
    );
  }

  Future<void> toggleStatus() async {
    if (status == 'frozen') {
      await context.runProcess(UnfreezeCounterRequested(counterId: id));
    } else {
      await context.runProcess(FreezeCounterRequested(counterId: id));
    }
  }
}

class CounterDetailsException implements Exception {
  const CounterDetailsException(this.message);

  final String message;

  @override
  String toString() => message;
}
