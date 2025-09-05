import 'package:horda_client/horda_client.dart';

import '../counter_details/query.dart';

class CounterListQuery extends EntityQuery {
  final counters = EntityListView('counters', query: CounterQuery());

  @override
  void initViews(EntityQueryGroup views) {
    views.add(counters);
  }
}
