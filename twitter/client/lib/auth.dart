import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:horda_client/horda_client.dart';
import 'package:logging/logging.dart';

final kAuthService = FirebaseAuthService();

class FirebaseAuthService implements AuthProvider {
  FirebaseAuthService();

  final logger = Logger('Auth');

  @override
  Future<String?> getFirebaseIdToken() async {
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

  Future<void> deleteCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
        logger.info('Firebase user deleted successfully');
      }
    } on FirebaseAuthException catch (e) {
      logger.severe('Error deleting Firebase user: ${e.message}');
      throw AuthException(e.message ?? 'Failed to delete Firebase user.');
    } catch (e) {
      logger.severe('Unexpected error deleting Firebase user: $e');
      throw AuthException(
        'An unexpected error occurred while deleting user: $e',
      );
    }
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
