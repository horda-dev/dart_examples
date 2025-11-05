## 0.1.5

- **BREAKING CHANGE**: Update process naming to match horda_server API changes:
  - `Process` → `ProcessGroup`
  - `initHandlers()` → `registerFuncs()`
  - `ProcessHandlers` → `ProcessFuncs`
  - `FlowResult` → `ProcessResult`
- **BREAKING CHANGE**: Convert `CounterListEntity` to singleton entity using `kSingletonId`.
- Remove `CreateCounterList` command and `CreateCounterListRequested` process.
- Use horda_server 0.18.0.
- Add dev dependency horda_local_host 0.1.0

## 0.1.4

- Use horda_server 0.14.0.

## 0.1.3

- Rename fields in view groups.
- Use horda_server 0.13.0.

## 0.1.2

- Use horda_client 0.19.0 with renamed API.
- Rename 'frozeStatus' view to 'freezeStatus' in CounterViewGroup.
- Add doc comments.
- Add README.md.

## 0.1.1

- Fix freezing/unfreezing CounterEntity
- Add missing exports, which are necessary for successful deployment.

## 0.1.0

- Initial version.
