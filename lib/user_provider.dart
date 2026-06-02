import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';
import 'database_service.dart';

class UserProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();

  User? _user;
  Map<String, dynamic>? _userData;
  bool _isLoading = false;

  User? get user => _user;
  Map<String, dynamic>? get userData => _userData;
  bool get isLoading => _isLoading;
  String? get userRole => _userData?['role'];
  String? get userName => _userData?['name'];
  String? get userEmail => _userData?['email'];

  UserProvider() {
    print('UserProvider: Initializing');
    _authService.authStateChanges.listen((User? user) {
      print('UserProvider: Auth state changed - User: ${user?.uid}');
      _user = user;
      if (user != null) {
        loadUserData();
      } else {
        _userData = null;
      }
      notifyListeners();
    });
  }

  // Load user data from Firestore
  Future<void> loadUserData() async {
    if (_user == null) {
      print('loadUserData: No user logged in');
      return;
    }

    print('loadUserData: Loading data for user ${_user!.uid}');
    _isLoading = true;
    notifyListeners();

    _userData = await _authService.getUserData(_user!.uid);
    print('loadUserData: Loaded data: $_userData');

    _isLoading = false;
    notifyListeners();
  }

  // Sign in
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final result = await _authService.signIn(email: email, password: password);

    _isLoading = false;
    notifyListeners();

    return result;
  }

  // Sign up
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String name,
    required String role,
    Map<String, dynamic>? additionalData,
  }) async {
    _isLoading = true;
    notifyListeners();

    final result = await _authService.signUp(
      email: email,
      password: password,
      name: name,
      role: role,
      additionalData: additionalData,
    );

    _isLoading = false;
    notifyListeners();

    return result;
  }

  // Sign out
  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    _userData = null;
    notifyListeners();
  }

  // Update user profile
  Future<bool> updateProfile(Map<String, dynamic> data) async {
    if (_user == null) return false;

    _isLoading = true;
    notifyListeners();

    bool success = await _authService.updateUserData(_user!.uid, data);

    if (success) {
      await loadUserData();
    }

    _isLoading = false;
    notifyListeners();

    return success;
  }

  // Change password
  Future<Map<String, dynamic>> changePassword(String currentPassword, String newPassword) async {
    return await _authService.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  // Reset password
  Future<Map<String, dynamic>> resetPassword(String email) async {
    return await _authService.resetPassword(email);
  }
}
