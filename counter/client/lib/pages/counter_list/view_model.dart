import 'package:counter_server/counter_server.dart';
import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';

import 'query.dart';

class CounterListViewModel {
  CounterListViewModel(this.context) : system = HordaSystemProvider.of(context);

  final BuildContext context;

  final HordaClientSystem system;

  int get countersLength {
    return context.query<CounterListQuery>().listLength((q) => q.counters);
  }

  CounterListItem getCounter(int index) {
    final counter = context.query<CounterListQuery>().listItem(
      (q) => q.counters,
      index,
    );

    return CounterListItem(
      counter.id(),
      counter.value((q) => q.counterName),
      counter.value((q) => q.freezeStatus),
      counter.counter((q) => q.counterValue),
    );
  }

  Future<void> createCounterList() async {
    final res = await system.dispatchEvent(CreateCounterListRequested());
    if (res.isError) {
      throw CounterListException(res.value ?? '');
    }
  }

  Future<void> addCounter(String name, int initialValue) async {
    final res = await system.dispatchEvent(
      CreateCounterRequested(name: name, initialValue: initialValue),
    );
    if (res.isError) {
      throw CounterListException(res.value ?? '');
    }
  }
}

class CounterListItem {
  CounterListItem(this.id, this.name, this.status, this.value);

  final String id;
  final String name;
  final String status;
  final int value;
}

class CounterListException implements Exception {
  const CounterListException(this.message);

  final String message;

  @override
  String toString() => message;
}
