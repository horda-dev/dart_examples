import 'package:horda_client/horda_client.dart';

class CounterQuery extends ActorQuery {
  final counterName = ActorValueView<String>('name');

  final counterValue = ActorCounterView('value');

  final frozeStatus = ActorValueView<String>('frozeStatus');

  @override
  void initViews(ActorQueryGroup views) {
    views
      ..add(counterName)
      ..add(counterValue)
      ..add(frozeStatus);
  }
}
