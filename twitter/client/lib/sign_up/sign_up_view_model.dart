import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';

import '../auth.dart';

class SignUpViewModel {
  final BuildContext context;
  final HordaClientSystem system;

  SignUpViewModel(this.context) : system = HordaSystemProvider.of(context);

  Future<void> signUp({
    required String handle,
    required String displayName,
    required String email,
    required String password,
  }) async {
    await kAuthService.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );

    // No need to check FlowResult.isError here, as signUpWithEmailAndPassword
    // will throw AuthException on failure.

    // Optionally, you might still want to dispatch an event to the Horda backend
    // to register the user's profile details (handle, displayName) after Firebase auth.
    // This would involve a new client event like ClientUserProfileCreatedRequested.
    // For now, we'll just focus on Firebase auth.
  }
}
