import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:horda_client/horda_client.dart';
import 'package:logging/logging.dart';

import 'config.dart';

final kAuthService = FirebaseAuthService();

class FirebaseAuthService implements AuthProvider {
  FirebaseAuthService();

  final logger = Logger('Auth');

  Future<void> reopenWebSocket({required HordaProcessContext context}) async {
    final conn = LoggedInConfig(url: kUrl, apiKey: kApiKey);
    context.changeConnection(conn);
  }

  @override
  Future<String?> getIdToken() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      return await user?.getIdToken(true);
    } catch (e) {
      logger.info('getIdToken() error: $e');
      return null;
    }
  }

  Future<String?> getUserId() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      return user?.uid;
    } catch (e) {
      logger.severe('getUserId() error: $e');
      return null;
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Firebase authentication error.');
    } catch (e) {
      throw AuthException('An unexpected error occurred during sign in: $e');
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Firebase authentication error.');
    } catch (e) {
      throw AuthException('An unexpected error occurred during sign up: $e');
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  String? getUserEmail() {
    return FirebaseAuth.instance.currentUser?.email;
  }
}

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => 'AuthException: $message';
}
