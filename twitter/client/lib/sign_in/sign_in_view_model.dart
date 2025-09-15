import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_server/twitter_server.dart';

import 'sign_in_exception.dart';

class SignInViewModel {
  final BuildContext context;
  late final HordaClientSystem _hordaSystem;

  SignInViewModel(this.context) {
    _hordaSystem = HordaSystemProvider.of(context);
  }

  Future<void> signIn() async {
    final event = ClientLogInUserRequested(); // No parameters
    final result = await _hordaSystem.dispatchEvent(event);

    if (result.isError) {
      throw SignInException(result.value ?? 'Unknown sign in error.');
    }
  }
}
