import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_server/twitter_server.dart';

import '../auth.dart';
import '../config.dart';
import '../main.dart';
import '../router.dart';

class SignUpViewModel {
  final BuildContext context;
  final HordaClientSystem system;

  SignUpViewModel(this.context) : system = HordaSystemProvider.of(context);

  Future<void> signUp({
    required String handle,
    required String displayName,
    required String email,
    required String password,
    required String avatarBase64,
  }) async {
    await kAuthService.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );

    gIsSigningUp = true;

    system.reopen(
      NoAuthConfig(url: kUrl, apiKey: kApiKey),
    );

    // Has to be done, because we can't wait until the connection is reopened.
    await Future.delayed(const Duration(seconds: 30));

    final result = await system.dispatchEvent(
      ClientRegisterUserRequested(
        handle,
        displayName,
        email,
        avatarBase64,
      ),
    );
    
    gIsSigningUp = false;

    if (result.isError) {
      throw Exception(result.value ?? 'Failed to register user profile.');
    }
  }
}
