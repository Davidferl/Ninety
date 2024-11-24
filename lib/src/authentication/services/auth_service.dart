import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../exceptions/exceptions.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  bool isLogged() => _auth.currentUser != null;

  User? get currentUser {
    return _auth.currentUser;
  }

  Stream<User?> get userStream {
    return _auth.authStateChanges();
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      await _messaging.subscribeToTopic("user_${credential.user!.uid}");
    } on FirebaseAuthException {
      throw const AuthenticationException(
        message: 'Invalid email or password.',
      );
    } catch (e) {
      throw const AuthenticationException(
        message: 'Something went wrong. Please try again later.',
      );
    }
  }

  Future<void> register(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _messaging.subscribeToTopic("user_${credential.user!.uid}");
    } on FirebaseAuthException {
      throw const AuthenticationException(
        message: 'Invalid email or password.',
      );
    } catch (e) {
      throw const AuthenticationException(
        message: 'Something went wrong. Please try again later.',
      );
    }
  }

  Future<void> logout() async {
    try {
      await _messaging.unsubscribeFromTopic("user_${_auth.currentUser!.uid}");
      await _auth.signOut();
    } on FirebaseAuthException {
      throw const AuthenticationException(
        message: 'Something went wrong. Please try again later.',
      );
    }
  }
}
