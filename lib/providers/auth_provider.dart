import 'package:flutter/foundation.dart';
import 'package:moodle/data/dummy_data.dart';
import 'package:moodle/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({AuthService? authService})
      : _authService = authService ?? AuthService();

  final AuthService _authService;

  bool _isLoading = false;

  bool get isLoggedIn => _authService.isLoggedIn;
  bool get isLoading => _isLoading;
  DummyUserProfile get user => _authService.currentUser;

  Future<bool> signIn({required String email, required String password}) async {
    _isLoading = true;
    notifyListeners();

    final success =
        await _authService.signIn(email: email, password: password);

    _isLoading = false;
    notifyListeners();
    return success;
  }

  Future<void> signOut() async {
    await _authService.signOut();
    notifyListeners();
  }
}
