import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';

import '../../common/alert_dialog.dart';
import 'query.dart';
import 'view_model.dart';

class CounterDetailsPage extends StatelessWidget {
  const CounterDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String?;

    if (id == null) {
      return const _ErrorPage(
        message: 'Counter ID not found in route arguments.',
      );
    }

    return context.entityQuery(
      entityId: id,
      query: CounterQuery(),
      loading: const _LoadingPage(),
      error: const _ErrorPage(),
      child: const _LoadedPage(),
    );
  }
}

class _ErrorPage extends StatelessWidget {
  const _ErrorPage({this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(child: Text(message ?? 'Failed to load counter details')),
    );
  }
}

class _LoadingPage extends StatelessWidget {
  const _LoadingPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _LoadedPage extends StatefulWidget {
  const _LoadedPage();

  @override
  State<_LoadedPage> createState() => _LoadedPageState();
}

class _LoadedPageState extends State<_LoadedPage> {
  late final CounterDetailsViewModel model;
  var _isDeleting = false;

  @override
  void initState() {
    super.initState();
    model = CounterDetailsViewModel(context);
  }

  Future<void> _onDelete() async {
    setState(() {
      _isDeleting = true;
    });
    try {
      await model.delete();
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        showAlertDialog(
          context,
          title: 'Failed to delete counter',
          message: e.toString(),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDeleting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.name),
        actions: [
          if (_isDeleting)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            IconButton(
              color: Colors.red,
              icon: const Icon(Icons.delete),
              onPressed: _onDelete,
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${model.value}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'toggleFAB',
            onPressed: model.toggleStatus,
            tooltip: model.isFrozen ? 'Unfreeze' : 'Freeze',
            child: Icon(model.isFrozen ? Icons.play_arrow : Icons.pause),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'decrementFAB',
            onPressed: model.decrement,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'incrementFAB',
            onPressed: model.increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
