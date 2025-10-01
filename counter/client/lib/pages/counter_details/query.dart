import 'package:horda_client/horda_client.dart';

class CounterQuery extends EntityQuery {
  @override
  String get entityName => 'CounterEntity';

  final counterName = EntityValueView<String>('name');

  final counterValue = EntityCounterView('value');

  final freezeStatus = EntityValueView<String>('freezeStatus');

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(counterName)
      ..add(counterValue)
      ..add(freezeStatus);
  }
}
