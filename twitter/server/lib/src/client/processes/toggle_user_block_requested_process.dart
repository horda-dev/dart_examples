import 'package:horda_server/horda_server.dart';

import '../../../twitter_server.dart';

/// {@category Process}
///
/// Handles the ToggleUserBlockRequested business process:
/// 1. Sends 'ToggleUserBlock' command to 'UserAccountEntity'.
/// 2. Waits for 'UserBlocked' or 'UserUnblocked' event.
/// 3. Completes the process upon successful toggling.
Future<ProcessResult> clientToggleUserBlockRequested(
  ClientToggleUserBlockRequested event,
  ProcessContext context,
) async {
  await context.callEntityDynamic(
    name: 'UserAccountEntity',
    id: context.senderId!,
    cmd: ToggleUserBlock(
      event.userId,
    ),
    fac: [
      UserBlocked.fromJson,
      UserUnblocked.fromJson,
    ],
  );

  return ProcessResult.ok();
}
