import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_server/twitter_server.dart';

import 'sign_up_exception.dart';

class SignUpViewModel {
  final BuildContext context;
  late final HordaClientSystem _hordaSystem;

  SignUpViewModel(this.context) {
    _hordaSystem = HordaSystemProvider.of(context);
  }

  Future<void> signUp({
    required String handle,
    required String displayName,
    required String email,
  }) async {
    final event = ClientRegisterUserRequested(handle, displayName, email);
    final result = await _hordaSystem.dispatchEvent(event);

    if (result.isError) {
      throw SignUpException(result.value ?? 'Unknown sign up error.');
    }
  }
}
