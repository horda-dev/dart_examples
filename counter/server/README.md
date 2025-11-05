# Counter Example Backend

## Overview

A "Hello World" project showcasing basic Horda Server SDK concepts including Entity, State, and View Group, and how to use them to create a stateful serverless backend.

You can view the Counter example in the [Horda Console](https://console.horda.dev/?project=d2sqf8kgc98s73838big).

## Local Development

### 1. Development Dependency `horda_local_host`

This server package has a development dependency on the `horda_local_host` package. This allows you to run the build runner to generate a `main.dart` file and run the server package locally.

When developing your own `horda_server` packages, you can add `horda_local_host` as a development dependency to your project.

To ensure all necessary Dart packages are fetched, run:
```bash
dart pub get
```

### 2. Generate Code
To generate the code:
```bash
dart run build_runner build
```
Note that `build_runner` will only regenerate `bin/main.dart` if it detects changes in other Dart files. If you have manually modified `bin/main.dart` and wish to regenerate it, you must first clean the build cache before running the build command again.

```bash
dart run build_runner clean
dart run build_runner build
```

### 3. Run the Application
After generating the `main.dart` file, you can run the local host in VSCode by pressing F5. Alternatively, you can run it from the command line as usual:
```bash
dart bin/main.dart
```

### 4. Connect Client
To connect to the locally hosted server package, clients must use:
- `"ws://localhost:8080/client"` for local development.
- `"ws://10.0.2.2:8080/client"` if running on an Android emulator.

## Processes

**Location:** `lib/src/processes/counter.dart`

**Process Request Events:**
- `CreateCounterRequested` - Request to create a new counter with validation
- `DeleteCounterRequested` - Request to delete a counter and remove from list
- `IncrementCounterRequested` - Request to increment a counter
- `DecrementCounterRequested` - Request to decrement a counter
- `FreezeCounterRequested` - Request to freeze a counter
- `UnfreezeCounterRequested` - Request to unfreeze a counter

## Entities

### CounterEntity
**Location:** `lib/src/entities/counter/`

An entity representing a simple counter with freeze/unfreeze functionality.

#### Entity Commands
- `CreateCounter` - Command to create a new counter with name and initial value
- `DeleteCounter` - Command to delete an existing counter
- `IncrementCounter` - Command to increment a counter by a specified amount
- `DecrementCounter` - Command to decrement a counter by a specified amount  
- `FreezeCounter` - Command to freeze a counter, preventing modifications
- `UnfreezeCounter` - Command to unfreeze a counter, allowing modifications

#### Entity Views
- `nameView` - View displaying the counter's name (ValueView<String>)
- `valueView` - View displaying and managing the counter's numeric value (CounterView)
- `freezeStatusView` - View displaying the counter's freeze status as text (ValueView<String>)

### CounterListEntity
**Location:** `lib/src/entities/counter_list/`

A singleton entity that manages the global list of counter references. As a singleton, only one instance exists in the system and it doesn't need to be manually created.

#### Entity Commands
- `AddCounterToList` - Command to add a counter reference to the list
- `RemoveCounterFromList` - Command to remove a counter reference from the list

#### Entity Views
- `countersView` - View displaying the list of counter references (RefListView)

## Services

### ValidationService
**Location:** `lib/src/services/validation/`

A service for validating counter-related data and business rules.

#### Service Commands
- `ValidateCounterName` - Command to validate a counter name according to business rules
