import 'package:horda_server/horda_server.dart';

import 'messages.dart';

/// View group for counter entities that manages client-side representations.
///
/// This class handles how counter data is presented to clients, including
/// the counter name, current value, and freeze status.
class CounterViewGroup extends EntityViewGroup {
  /// View displaying the counter's name.
  final ValueView<String> name;

  /// View displaying and managing the counter's numeric value.
  final CounterView value;

  /// View displaying the counter's freeze status as text.
  final ValueView<String> freezeStatus;

  /// Creates a default counter view group with empty initial values.
  CounterViewGroup()
    : name = ValueView(name: 'name', value: ''),
      value = CounterView(name: 'value', value: 0),
      freezeStatus = ValueView(name: 'freezeStatus', value: "not frozen");

  /// Creates a counter view group initialized from a [CounterCreated] event.
  ///
  /// [event] contains the initial counter name and count value.
  CounterViewGroup.fromInitEvent(CounterCreated event)
    : name = ValueView(name: 'name', value: event.name),
      value = CounterView(name: 'value', value: event.count),
      freezeStatus = ValueView(name: 'freezeStatus', value: "not frozen");

  /// Handles counter increment events by updating the value view.
  ///
  /// [event] contains the amount by which the counter was incremented.
  void incremented(CounterIncremented event) {
    value.increment(event.amount);
  }

  /// Handles counter decrement events by updating the value view.
  ///
  /// [event] contains the amount by which the counter was decremented.
  void decremented(CounterDecremented event) {
    value.decrement(event.amount);
  }

  /// Handles freeze status changes by updating the freeze status view.
  ///
  /// [event] contains the new freeze status (true for frozen, false for unfrozen).
  void freezeChanged(CounterFreezeChanged event) {
    if (event.newValue) {
      freezeStatus.value = "frozen";
    } else {
      freezeStatus.value = "not frozen";
    }
  }

  @override
  void initViews(ViewGroup views) {
    views
      ..add(name)
      ..add(value)
      ..add(freezeStatus);
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
