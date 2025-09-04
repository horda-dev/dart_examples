import 'package:counter_server/counter_server.dart';
import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';

import 'add_counter_sheet.dart';
import 'query.dart';
import 'view_model.dart';

class CounterListPage extends StatelessWidget {
  const CounterListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return context.actorQuery(
      actorId: kCounterListEntityId,
      query: CounterListQuery(),
      loading: const _LoadingPage(),
      error: const _ErrorPage(),
      child: const _LoadedPage(),
    );
  }
}

class _LoadingPage extends StatelessWidget {
  const _LoadingPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _ErrorPage extends StatelessWidget {
  const _ErrorPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Error loading counters')));
  }
}

class _LoadedPage extends StatefulWidget {
  const _LoadedPage(); // No longer needs model as a parameter

  @override
  State<_LoadedPage> createState() => _LoadedPageState();
}

class _LoadedPageState extends State<_LoadedPage> {
  late final CounterListViewModel model;

  @override
  void initState() {
    super.initState();
    model = CounterListViewModel(context);

    // Since the counter list is global, no need to do it if the project already has it created.
    // model.createCounterList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counters')),
      body: (model.countersLength == 0)
          ? const Center(
              child: Text(
                'No counters yet, but you can create one!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: model.countersLength,
              itemBuilder: (context, index) {
                final counter = model.getCounter(index);

                return ListTile(
                  title: Text(
                    counter.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    counter.status == 'frozen' ? 'Frozen' : 'Unfrozen',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: Text(
                    counter.value.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/counter',
                    arguments: counter.id,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddCounterPressed,
        tooltip: 'Add Counter',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _onAddCounterPressed() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddCounterSheet(model: model),
      ),
    );
  }
}
