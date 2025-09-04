import 'package:horda_server/horda_server.dart';

import 'messages.dart';

class CounterListViewGroup extends EntityViewGroup {
  final RefListView countersView = RefListView(name: 'counters');

  CounterListViewGroup();

  CounterListViewGroup.fromInitEvent(CounterListCreated event);

  void counterAdded(CounterAddedToList event) {
    countersView.addItem(event.counterId);
  }

  void counterRemoved(CounterRemovedFromList event) {
    countersView.removeItem(event.counterId);
  }

  @override
  void initViews(ViewGroup views) {
    views.add(countersView);
  }

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {
    projectors
      ..addInit<CounterListCreated>(CounterListViewGroup.fromInitEvent)
      ..add<CounterAddedToList>(counterAdded)
      ..add<CounterRemovedFromList>(counterRemoved);
  }
}
