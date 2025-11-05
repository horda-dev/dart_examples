# Counter Example Client

## Overview

Counter Flutter app showcasing how to use Horda Client SDK to connect to Horda Counter backend, request business processes, query entity views, and display results.

You can view the Counter example in the [Horda Console](https://console.horda.dev/?project=d2sqf8kgc98s73838big).

## Demo:

<div align="center">
  <video src="https://github.com/user-attachments/assets/679eef38-0caa-4096-bd41-bb258dc2bdd7" />
</div>

### Backend Connection

The connection to the Counter backend is established in the `main.dart` file. The process involves these steps:

1.  A `projectId` and `apiKey` are defined to identify the backend project.
2.  A WebSocket URL is constructed in the format `wss://api.horda.dev/[PROJECT_ID]/client`.
    To connect to a locally hosted server package, clients must use:
    - `"ws://localhost:8080/client"` for local development.
    - `"ws://10.0.2.2:8080/client"` if running on an Android emulator.
3.  The `HordaClientSystem` is initialized directly with the `url` and `apiKey`. The `HordaClientSystem` constructor also accepts an optional `authProvider` parameter, but it is not supplied here as this project does not feature authentication.
4.  The `system.start()` method is called to initiate the connection.
5.  The root widget of the application is wrapped in a `HordaSystemProvider`, making the client system available to all descendant widgets.

```dart
// In main.dart

// 1. Configuration
final projectId = '[PROJECT_ID]';
final apiKey = '[API_KEY]';
final url = 'wss://api.horda.dev/$projectId/client';

// 2. System Initialization
final system = HordaClientSystem(url: url, apiKey: apiKey);
system.start();

// 3. Provider Setup
runApp(HordaSystemProvider(system: system, child: const CounterClient()));
```

### Screens and Data Display

The application is composed of two screens:
1.  **Counter List Screen** (`counter/client/lib/pages/counter_list/page.dart`): This screen displays a list of all available counters.
2.  **Counter Details Screen** (`counter/client/lib/pages/counter_details/page.dart`): This screen shows the details of a single counter and provides buttons for interaction.

Both screens use the `entityQuery` context extension method from the Horda Client SDK package to run a query and subscribe to live data from the server.

Here is an example of how it's used in the `CounterDetailsPage`:

```dart
return context.entityQuery(
  entityId: id,
  query: CounterQuery(),
  loading: const _LoadingPage(),
  error: const _ErrorPage(),
  child: const _LoadedPage(),
);
```

Any descendant widget can then access the data from the query's result using the `context.query<T>()` method, where `T` is the type of the query class.

For example, the `CounterDetailsViewModel` accesses the counter's name like this:

```dart
String get name {
  return context.query<CounterQuery>().value((q) => q.counterName);
}
```

The screens define the following custom `EntityQuery` classes to specify which data views they need from the server's corresponding `ViewGroup`.

*   **CounterListQuery** (`counter/client/lib/pages/counter_list/query.dart`)

    This query fetches the list of counter IDs.

    ```dart
    class CounterListQuery extends EntityQuery {
      final counters = EntityListView('counters', query: CounterQuery());
    
      @override
      void initViews(EntityQueryGroup views) {
        views.add(counters);
      }
    }
    ```

*   **CounterQuery** (`counter/client/lib/pages/counter_details/query.dart`)

    This query defines the specific data fields to retrieve for each counter: its name, value, and freeze status.

    ```dart
    class CounterQuery extends EntityQuery {
      final counterName = EntityValueView<String>('name');
    
      final counterValue = EntityCounterView('value');
    
      final freezeStatus = EntityValueView<String>('freezeStatus');
    
      @override
      void initViews(EntityQueryGroup views) {
        views
          ..add(counterName)
          ..add(counterValue)
          ..add(freezeStatus);
      }
    }
    ```

### Requesting Server Business Processes

User interactions, such as pressing a button to increment a counter or create a new one, are handled by a `ViewModel`. The ViewModel methods dispatch client events to the server to request specific business process. For example, when a user creates a counter, the client sends a `CreateCounterRequested` event, which triggers the corresponding `create` business process on the server.

For instance, the `CounterDetailsViewModel` uses the `dispatchEvent` context extension method to send an event to the server:

```dart
class CounterDetailsViewModel {
  CounterDetailsViewModel(this.context);

  final BuildContext context;

  // ...

  Future<void> increment() async {
    await context.runProcess(
      IncrementCounterRequested(counterId: id, amount: 1),
    );
  }

  // ...
}
```
