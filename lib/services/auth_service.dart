import 'package:moodle/data/dummy_data.dart';

class AuthService {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  DummyUserProfile get currentUser => dummyUserProfile;

  /// Stub login — replace with Firebase Auth for the Advanced tier.
  Future<bool> signIn({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _isLoggedIn = email.isNotEmpty && password.isNotEmpty;
    return _isLoggedIn;
  }

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    _isLoggedIn = false;
  }
}
