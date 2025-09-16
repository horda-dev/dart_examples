import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_client/auth.dart'; // Import kAuthService

import 'sign_in_exception.dart';

class SignInViewModel {
  final BuildContext context;
  late final HordaClientSystem _hordaSystem;

  SignInViewModel(this.context) {
    _hordaSystem = HordaSystemProvider.of(context);
  }

  Future<void> signIn({required String email, required String password}) async {
    await kAuthService.signInWithEmailAndPassword(email: email, password: password);
    // No need to check FlowResult.isError here, as signInWithEmailAndPassword
    // will throw AuthException on failure.
  }
}