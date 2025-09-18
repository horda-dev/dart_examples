import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';

import '../auth.dart';
import '../main.dart';

class SignInViewModel {
  final BuildContext context;
  final HordaClientSystem system;

  SignInViewModel(this.context) : system = HordaSystemProvider.of(context);

  Future<void> signIn({required String email, required String password}) async {
    await kAuthService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    system.reopen(
      NoAuthConfig(
        url: system.connectionConfig.url,
        apiKey: system.connectionConfig.apiKey,
      ),
    );
  }
}
