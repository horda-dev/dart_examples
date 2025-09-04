import 'package:horda_server/horda_server.dart';

import 'messages.dart';

class CounterViewGroup extends EntityViewGroup {
  final ValueView<String> nameView;
  final CounterView valueView;
  final ValueView<String> frozenStateView;

  CounterViewGroup()
    : nameView = ValueView(name: 'name', value: ''),
      valueView = CounterView(name: 'value', value: 0),
      frozenStateView = ValueView(name: 'frozeStatus', value: "not frozen");

  CounterViewGroup.fromInitEvent(CounterCreated event)
    : nameView = ValueView(name: 'name', value: event.name),
      valueView = CounterView(name: 'value', value: event.count),
      frozenStateView = ValueView(name: 'frozeStatus', value: "not frozen");

  void incremented(CounterIncremented event) {
    valueView.increment(event.amount);
  }

  void decremented(CounterDecremented event) {
    valueView.decrement(event.amount);
  }

  void freezeChanged(CounterFreezeChanged event) {
    if (event.newValue) {
      frozenStateView.value = "frozen";
    } else {
      frozenStateView.value = "not frozen";
    }
  }

  @override
  void initViews(ViewGroup views) {
    views
      ..add(nameView)
      ..add(valueView)
      ..add(frozenStateView);
  }

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {
    projectors
      ..addInit<CounterCreated>(CounterViewGroup.fromInitEvent)
      ..add<CounterIncremented>(incremented)
      ..add<CounterDecremented>(decremented)
      ..add<CounterFreezeChanged>(freezeChanged);
  }
}
