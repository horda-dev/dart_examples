import 'package:horda_server/horda_server.dart';

import 'messages.dart';

class CounterViewGroup extends EntityViewGroup {
  final ValueView<String> nameView;
  final CounterView valueView;
  final ValueView<String> frozenStateView;

  CounterViewGroup.fromInitEvent(CounterCreatedEvent event)
    : nameView = ValueView(name: 'name', value: event.name),
      valueView = CounterView(name: 'value', value: event.count),
      frozenStateView = ValueView(name: 'isFroze', value: "not frozen");

  void incremented(CounterIncrementedEvent event) {
    valueView.increment(event.amount);
  }

  void decremented(CounterDecrementedEvent event) {
    valueView.decrement(event.amount);
  }

  void freezeChanged(CounterFreezeChangedEvent event) {
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
      ..addInit<CounterCreatedEvent>(CounterViewGroup.fromInitEvent)
      ..add<CounterIncrementedEvent>(incremented)
      ..add<CounterDecrementedEvent>(decremented)
      ..add<CounterFreezeChangedEvent>(freezeChanged);
  }
}
