import 'package:counter_server/counter_server.dart';
import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';

import 'query.dart';

class CounterListViewModel {
  CounterListViewModel(this.context);

  final BuildContext context;

  int get countersLength {
    return context.query<CounterListQuery>().listLength((q) => q.counters);
  }

  CounterListItem getCounter(int index) {
    final listQuery = context.query<CounterListQuery>();
    final counterQuery = listQuery.listItemQuery((q) => q.counters, index);

    return CounterListItem(
      listQuery.listItem((q) => q.counters, index).key,
      counterQuery.id(),
      counterQuery.value((q) => q.counterName),
      counterQuery.value((q) => q.freezeStatus),
      counterQuery.counter((q) => q.counterValue),
    );
  }

  Future<void> addCounter(String name, int initialValue) async {
    final res = await context.runProcess(
      CreateCounterRequested(name: name, initialValue: initialValue),
    );

    if (res.isError) {
      final message = switch (res.value) {
        'counter name is invalid' =>
          'Counter name must not be longer than 10 characters.',
        _ => 'Something went wrong.',
      };

      throw CounterListException(message);
    }
  }
}

class CounterListItem {
  CounterListItem(this.itemKey, this.id, this.name, this.status, this.value);

  final String itemKey;
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
