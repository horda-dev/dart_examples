import 'package:horda_server/horda_server.dart';

import 'entity.dart';

class CounterListViewGroup extends EntityViewGroup {
  final RefListView countersView = RefListView(name: 'counters');

  void counterAdded(CounterAddedToListEvent event) {
    countersView.addItem(event.counterId);
  }

  void counterRemoved(CounterRemovedFromListEvent event) {
    countersView.removeItem(event.counterId);
  }

  @override
  void initViews(ViewGroup views) {
    views.add(countersView);
  }

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {
    projectors
      ..add<CounterAddedToListEvent>(counterAdded)
      ..add<CounterRemovedFromListEvent>(counterRemoved);
  }
}
