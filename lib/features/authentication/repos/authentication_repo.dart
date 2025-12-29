import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isLoggedIn => user != null;
  User? get user => _firebaseAuth.currentUser;

  Future<UserCredential> signUp(String email, String password, {String? username}) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Set displayName if username is provided
    if (username != null && username.isNotEmpty && credential.user != null) {
      await credential.user!.updateDisplayName(username);
      await credential.user!.reload();
    }

    return credential;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<UserCredential> signIn(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

final authRepo = Provider((ref) => AuthenticationRepository());
