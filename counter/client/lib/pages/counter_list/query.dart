import 'package:horda_client/horda_client.dart';

import '../counter_details/query.dart';

class CounterListQuery extends ActorQuery {
  final counters = ActorListView('counters', query: CounterQuery());

  @override
  void initViews(ActorQueryGroup views) {
    views.add(counters);
  }
}
