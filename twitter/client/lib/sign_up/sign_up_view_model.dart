import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_server/twitter_server.dart';

import '../auth.dart';
import '../router.dart';

class SignUpViewModel {
  final BuildContext context;

  SignUpViewModel(this.context);

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

    if (!context.mounted) {
      return;
    }

    gIsSigningUp = true;

    await context.reopenConnection();

    if (!context.mounted) {
      return;
    }

    try {
      final result = await context.runProcess(
        RegisterUserRequested(
          handle,
          displayName,
          email,
          avatarBase64,
        ),
      );

      if (result.isError) {
        throw Exception(result.value ?? 'Failed to register user profile.');
      }
    } catch (e) {
      await _rollbackPartialSignUp();
      rethrow;
    } finally {
      gIsSigningUp = false;
    }
  }

  /// Must be called when backend registration failed but Firebase Auth succeeded.
  ///
  /// Deletes the Firebase user to avoid orphaned accounts.
  Future<void> _rollbackPartialSignUp() async {
    try {
      await kAuthService.deleteCurrentUser();

      if (!context.mounted) {
        return;
      }

      await context.reopenConnection();
    } catch (e) {
      print(
        'Failed to rollback partial sign up: $e',
      );
    }
  }
}
