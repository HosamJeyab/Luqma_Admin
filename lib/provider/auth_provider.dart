import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:luqma_admin/controller/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmPasswordcontroller =
      TextEditingController();
  final TextEditingController emailcontrollersignin = TextEditingController();
  final TextEditingController passwordcontrollersigin = TextEditingController();

  @override
  void dispose() {
    usernamecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmPasswordcontroller.dispose();
    emailcontrollersignin.dispose();
    passwordcontrollersigin.dispose();
    super.dispose();
  }

  final AuthController _authController = AuthController();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  //for sign in status
  bool _isSignIn = false;
  bool get isSignIn => _isSignIn;

  //for auto sign out
  bool _isAutoSignOut = false;
  bool get isAutoSignOut => _isAutoSignOut;

  // save sign in status
  Future<void> saveSignInStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('signInStatus', status);
  }

  // get sign in status
  Future<void> getSignInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isAutoSignOutEnabled = prefs.getBool('autoSignOut') ?? false;

    if (isAutoSignOutEnabled) {
      await firebase_auth.FirebaseAuth.instance.signOut();
      await prefs.setBool('signInStatus', false);
      _isSignIn = false;
    } else {
      _isSignIn = prefs.getBool('signInStatus') ?? false;

      if (firebase_auth.FirebaseAuth.instance.currentUser == null) {
        _isSignIn = false;
      }
    }
    notifyListeners();
  }

  // register user
  Future<bool> registerUser(
    String username,
    String email,
    String password,
  ) async {
    _isLoading = true;
    notifyListeners();
    User? user = await _authController.signUp(email, password);
    if (user != null) {
      await FirebaseFirestore.instance.collection('admins').doc(user.uid).set({
        'username': username,
        'email': email,
        'createdAt': DateTime.now(),
        'isAdmin': true,
      });
    }
    _isLoading = false;
    notifyListeners();
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  // sign in
  Future<bool> signIn(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance
              .collection('admins')
              .doc(userCredential.user!.uid)
              .get();

      if (userDoc.exists) {
        bool isAdmin = userDoc.get('isAdmin') ?? false;
        if (isAdmin) {
          _isLoading = false;
          await saveSignInStatus(true);
          notifyListeners();
          return true;
        } else {
          await FirebaseAuth.instance.signOut();
          await saveSignInStatus(false);
          _isLoading = false;
          notifyListeners();
          return false;
        }
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print(e);
      return false;
    }
  }

  // sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await saveSignInStatus(false);
    notifyListeners();
  }

  // auto sign out
  void toggleAutoSignOut() async {
    _isAutoSignOut = !_isAutoSignOut;
    await saveAutoSignOutPreference(_isAutoSignOut);
    notifyListeners();
  }

  // save auto sign out preference
  Future<void> saveAutoSignOutPreference(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('autoSignOut', status);
  }

  // load settings
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isAutoSignOut = prefs.getBool('autoSignOut') ?? false;
    _isSignIn = prefs.getBool('signInStatus') ?? false;
    notifyListeners();
  }

  // change password
  Future<bool> changePassword(String oldPassword, String newPassword) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(cred);

      await user.updatePassword(newPassword);
      return true;
    } catch (e) {
      print("Error changing password: $e");
      return false;
    }
  }

  // send password reset email
  Future<void> forgetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  // get user role
  Future<bool> getUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc =
          await FirebaseFirestore.instance
              .collection('admins')
              .doc(user.uid)
              .get();
      if (userDoc.exists) {
        return userDoc.get('isAdmin') ?? false;
      }
    }
    return false;
  }
}
