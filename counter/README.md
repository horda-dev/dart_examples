# Project Example: Counter

This project is a full-stack counter application demonstrating the capabilities of the Horda framework. It consists of a server-side application that manages the state and logic of counters, and a client application for user interaction.

### Core Features:
*   **Counter Creation and Deletion**: Ability to create new counters with an initial value and remove existing ones.
*   **Value Modification**: Counters can be incremented and decremented.
*   **State Control**: Counters can be "frozen" to prevent modifications and "unfrozen" to allow them.
*   **List Management**: A central list of all counters is maintained.

<div align="center">
  <video src="https://github.com/user-attachments/assets/679eef38-0caa-4096-bd41-bb258dc2bdd7" />
</div>

## Server-Side Implementation

The server-side application uses the `horda_server` package. It defines counter list and counter entities, each with its own messages, state, and view group. It also contain a service for validation and business processes to orchestrate operations like counter creation, incrementing, decrementing, etc.

### Server: Counter Entity

The `CounterEntity` in `counter/server/lib/src/entities/counter/entity.dart` defines the business logic for a single counter. It's a stateful entity that manages the state of a counter and follows an event-sourcing pattern.

#### Core Logic:

*   **Creation**: A counter is created with an initial value.
*   **Deletion**: A counter can be deleted.
*   **Increment/Decrement**: The counter's value can be changed, but only if it's not "frozen."
*   **Freezing/Unfreezing**: The entity can be "frozen" to prevent changes and "unfrozen" to allow them.

#### State and Views

*   **Entity State**: The internal state (`CounterState` in `counter/server/lib/src/entities/counter/state.dart`) holds private data, like the frozen status.
*   **Entity Views (ViewGroup)**: The `CounterViewGroup` (in `counter/server/lib/src/entities/counter/view_group.dart`) defines the publicly visible representation of the entity (name, value, freeze status).

### Server: Counter List Entity

The `CounterListEntity` (in `counter/server/lib/src/entities/counter_list/entity.dart`) manages a collection of counter entities.

#### Core Logic:

*   **Creation**: A new, empty counter list can be created.
*   **Adding/Removing Counters**: It handles adding and removing counter IDs from the list.

#### State and Views

*   **Entity State**: The `CounterListState` is empty, as the actual list is managed in the view.
*   **Entity Views (ViewGroup)**: The `CounterListViewGroup` contains a `countersView` that holds the list of counter IDs.

### Server: Business Processes

The `ClientProcesses` class (in `counter/server/lib/src/processes/counter.dart`) defines high-level business workflows, acting as an orchestrator for client requests.

#### Key Workflows:

*   **Counter Creation**: A multi-step process that validates the name, creates the `CounterEntity`, and adds it to the `CounterListEntity`.
*   **Counter Deletion**: Coordinates deleting a counter from its own entity and the list entity.
*   **Counter Interaction**: Simple processes that map client requests (increment, decrement, freeze, unfreeze) to the corresponding commands in the `CounterEntity`.

***

## Client-Side Implementation

The client is a Flutter application that uses the `horda_client` package to communicate with the server. It features two main screens for interacting with the counters.

### Server Connection

The connection to the server is established in the `main.dart` file. The process involves these steps:

1.  A `projectId` and `apiKey` are defined to identify the backend project.
2.  A WebSocket URL is constructed in the format `wss://api.horda.ai/[PROJECT_ID]/client`.
3.  A configuration object (`NoAuthConfig`) is created using the URL and API key.
4.  This configuration is used to initialize the `HordaClientSystem`.
5.  The `system.start()` method is called to initiate the connection.
6.  The root widget of the application is wrapped in a `HordaSystemProvider`, making the client system available to all descendant widgets.

```dart
// In main.dart

// 1. Configuration
final projectId = '[PROJECT_ID]';
final apiKey = '[API_KEY]';
final url = 'wss://api.horda.ai/$projectId/client';
final conn = NoAuthConfig(url: url, apiKey: apiKey);

// 2. System Initialization
final system = HordaClientSystem(conn, NoAuth());
system.start();

// 3. Provider Setup
runApp(HordaSystemProvider(system: system, child: const CounterClient()));
```

### Screens and Data Display

The application is composed of two screens:
1.  **Counter List Screen** (`counter/client/lib/pages/counter_list/page.dart`): This screen displays a list of all available counters.
2.  **Counter Details Screen** (`counter/client/lib/pages/counter_details/page.dart`): This screen shows the details of a single counter and provides buttons for interaction.

Both screens use the `entityQuery` context extension method from the `horda_client` package to run a query and subscribe to live data from the server. Based on the state of the query (e.g., loading, error, or success), this method builds one of the three provided widgets: `loading`, `error`, or `child`. When the query is successful, the `child` widget is built and the query results are made available to all of its descendant widgets. This is possible only in descendants of `HordaSystemProvider`, which is set up at the root of the application during the initial server connection.

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

### Requesting Actions

User interactions, such as pressing a button to increment a counter or create a new one, are handled by a `ViewModel`. The ViewModel methods dispatch client events to the server to request specific actions. For example, when a user creates a counter, the client sends a `CreateCounterRequested` event, which triggers the corresponding `create` business process on the server.

For instance, the `CounterDetailsViewModel` first retrieves the `HordaClientSystem` from the context, and then uses its `dispatchEvent` method to send an event to the server:

```dart
class CounterDetailsViewModel {
  CounterDetailsViewModel(this.context)
    : system = HordaSystemProvider.of(context);

  final HordaClientSystem system;

  // ...

  Future<void> increment() async {
    await system.dispatchEvent(
      IncrementCounterRequested(counterId: id, amount: 1),
    );
  }

  // ...
}
```
