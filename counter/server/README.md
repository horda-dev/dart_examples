# Counter Example Backend

## Overview

A "Hello World" project showcasing basic Horda Server SDK concepts including Entity, State, and View Group, and how to use them to create a stateful serverless backend.

You can view the Counter example in the [Horda Console](https://console.horda.ai/?project=d2sqf8kgc98s73838big).

## Processes

**Location:** `lib/src/processes/counter.dart`

**Process Request Events:**
- `CreateCounterListRequested` - Request to create the global counter list entity
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

An entity that manages a list of counter references.

#### Entity Commands
- `CreateCounterList` - Command to create a new counter list
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
