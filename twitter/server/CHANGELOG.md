## 0.1.4

- Reorganize business processes

## 0.1.3

- **BREAKING CHANGE**: Update process naming to match horda_server API changes:
  - `Process` → `ProcessGroup`
  - `initHandlers()` → `registerFuncs()`
  - `ProcessHandlers` → `ProcessFuncs`
  - `FlowResult` → `ProcessResult`
- **BREAKING CHANGE**: Convert `ExploreFeedEntity` to singleton entity using `kSingletonId`.
- Remove `CreateExploreFeed` command, `ExploreFeedCreated` and associated initialization handler.
- Use horda_server 0.18.0.
- Add dev dependency horda_local_host 0.1.0

## 0.1.2

- Use horda_server 0.14.0.

## 0.1.1

- Rename fields in view groups.
- Use horda_server 0.13.0.
- Reorganize business process code.

## 0.1.0

- Initial version.
