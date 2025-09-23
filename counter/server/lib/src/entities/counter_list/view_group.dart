import 'package:horda_server/horda_server.dart';

import '../counter/entity.dart';
import 'messages.dart';

/// View group for counter list entities that manages client-side list representation.
///
/// This class handles how a list of counter references is presented to clients,
/// managing the addition and removal of counter references from the view.
class CounterListViewGroup extends EntityViewGroup {
  /// View displaying the list of counter references.
  final RefListView<CounterEntity> counters = RefListView(name: 'counters');

  /// Creates a default counter list view group with an empty list.
  CounterListViewGroup();

  /// Creates a counter list view group initialized from a [CounterListCreated] event.
  ///
  /// [event] the initialization event (currently contains no specific data).
  CounterListViewGroup.fromInitEvent(CounterListCreated event);

  /// Handles counter addition events by adding the counter reference to the view.
  ///
  /// [event] contains the ID of the counter that was added to the list.
  void counterAdded(CounterAddedToList event) {
    counters.addItem(event.counterId);
  }

  /// Handles counter removal events by removing the counter reference from the view.
  ///
  /// [event] contains the ID of the counter that was removed from the list.
  void counterRemoved(CounterRemovedFromList event) {
    counters.removeItem(event.counterId);
  }

  @override
  void initViews(ViewGroup views) {
    views.add(counters);
  }

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {
    projectors
      ..addInit<CounterListCreated>(CounterListViewGroup.fromInitEvent)
      ..add<CounterAddedToList>(counterAdded)
      ..add<CounterRemovedFromList>(counterRemoved);
  }
}
