# Counter Example Server

## Project Description

A Horda's "hello world" backend that demonstrates key Horda concepts including entities, processes, and services working together to manage counter state and operations.

## Processes

**Location:** `lib/src/processes/counter.dart`

Process handler for client-initiated counter operations.

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

Entity representing a simple counter with freeze/unfreeze functionality.

#### Entity Commands
- `CreateCounter` - Command to create a new counter with name and initial value
- `DeleteCounter` - Command to delete an existing counter
- `IncrementCounter` - Command to increment a counter by specified amount
- `DecrementCounter` - Command to decrement a counter by specified amount  
- `FreezeCounter` - Command to freeze a counter, preventing modifications
- `UnfreezeCounter` - Command to unfreeze a counter, allowing modifications

#### Entity Views
- `nameView` - View displaying the counter's name (ValueView<String>)
- `valueView` - View displaying and managing the counter's numeric value (CounterView)
- `freezeStatusView` - View displaying the counter's freeze status as text (ValueView<String>)

### CounterListEntity
**Location:** `lib/src/entities/counter_list/`

An entity that manages a list of counter references.platform.

#### Entity Commands
- `CreateCounterList` - Command to create a new counter list
- `AddCounterToList` - Command to add a counter reference to the list
- `RemoveCounterFromList` - Command to remove a counter reference from the list

#### Entity Views
- `countersView` - View displaying the list of counter references (RefListView)

## Services

### ValidationService
**Location:** `lib/src/services/validation/`

Service for validating counter-related data and business rules.

#### Service Commands
- `ValidateCounterName` - Command to validate a counter name according to business rules
  - **Validation Rules:**
    - Maximum length: 10 characters
    - Additional rules can be added as needed
