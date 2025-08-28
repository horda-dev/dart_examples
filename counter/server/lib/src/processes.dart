import 'package:horda_server/horda_server.dart';

class CreateCounterRequested extends RemoteEvent {
  final String message;

  CreateCounterRequested({required this.message});

  factory CreateCounterRequested.fromJson(Map<String, dynamic> json) {
    return CreateCounterRequested(message: json['message'] as String);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}

class CreateCounterProcess extends Process {
  Future<FlowResult> handleStart(
    CreateCounterRequested event,
    ProcessContext context,
  ) async {
    print('Processing message: ${event.message}');

    return FlowResult.ok();
  }

  @override
  void initHandlers(ProcessHandlers handlers) {
    handlers.add<CreateCounterRequested>(
      handleStart,
      CreateCounterRequested.fromJson,
    );
  }
}
