import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiktok_challenge/features/authentication/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // 현재 로그인한 사용자 가져오기
  UserModel? getCurrentUser() {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;

    return UserModel(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      dateOfBirth: '',
      isVerified: user.emailVerified,
    );
  }

  // 로그인 상태 확인
  bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  // 로그아웃
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  // 사용자 등록 (회원가입)
  Future<UserModel> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception('Failed to create user');
      }

      return UserModel(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        dateOfBirth: '',
        isVerified: user.emailVerified,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else {
        throw Exception(e.message ?? 'Failed to sign up');
      }
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  // 로그인
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception('Failed to login');
      }

      return UserModel(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        dateOfBirth: '',
        isVerified: user.emailVerified,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided.');
      } else if (e.code == 'invalid-credential') {
        throw Exception('Invalid email or password.');
      } else {
        throw Exception(e.message ?? 'Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  // 사용자 정보 업데이트
  Future<void> updateUser(UserModel userModel) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.updateDisplayName(userModel.name);
    }
  }

  // 현재 사용자 저장 (Firebase는 자동으로 관리하므로 불필요)
  Future<void> setCurrentUser(UserModel user) async {
    // Firebase Auth는 자동으로 현재 사용자를 관리합니다.
    // 이 메서드는 호환성을 위해 유지하지만 실제로는 아무것도 하지 않습니다.
  }
}
