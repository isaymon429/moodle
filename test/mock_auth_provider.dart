import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/foundation.dart';
import 'package:moodle/providers/auth_provider.dart';

/// Simple mock AuthProvider for testing UI components without Firebase dependencies.
class MockAuthProvider extends ChangeNotifier implements AuthProvider {
  @override
  bool get isLoading => false;

  @override
  bool get isLoggedIn => false;

  @override
  User? get user => null;

  @override
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {}

  @override
  Future<void> signInWithGoogle() async {}

  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {}

  @override
  Future<void> resetPassword(String email) async {}

  @override
  Future<void> signOut() async {}
}
