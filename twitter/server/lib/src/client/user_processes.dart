import 'package:horda_server/horda_server.dart';

import 'processes/register_user_requested_process.dart';
import 'processes/toggle_user_block_requested_process.dart';
import 'processes/toggle_user_follow_requested_process.dart';
import 'processes/update_user_profile_requested_process.dart';
import 'messages.dart';

class UserProcesses extends ProcessGroup {
  @override
  void registerFuncs(ProcessFuncs funcs) {
    funcs.add<ClientRegisterUserRequested>(
      clientRegisterUserRequested,
      ClientRegisterUserRequested.fromJson,
    );
    funcs.add<ClientUpdateUserProfileRequested>(
      clientUpdateUserProfileRequested,
      ClientUpdateUserProfileRequested.fromJson,
    );
    funcs.add<ClientToggleUserFollowRequested>(
      clientToggleUserFollowRequested,
      ClientToggleUserFollowRequested.fromJson,
    );
    funcs.add<ClientToggleUserBlockRequested>(
      clientToggleUserBlockRequested,
      ClientToggleUserBlockRequested.fromJson,
    );
  }
}
