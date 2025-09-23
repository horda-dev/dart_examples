BusinessProcess is an orchestration of entities and services to fulfil client-initiated request.

A business process does only the following things:
- Sends commands to entities and services
- Receives events as a result of command being sent handling by entity and service
- Decides what to do next, based on received event type and/or payload
- Completes the process when all required work is done