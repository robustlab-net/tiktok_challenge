import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_challenge/features/authentication/models/user_model.dart';

class AuthRepository {
  static const String _currentUserKey = "currentUser";
  static const String _usersKey = "users";
  static const String _isLoggedInKey = "isLoggedIn";

  final SharedPreferences _preferences;

  AuthRepository(this._preferences);

  // 현재 로그인한 사용자 저장
  Future<void> setCurrentUser(UserModel user) async {
    await _preferences.setString(_currentUserKey, json.encode(user.toJson()));
    await _preferences.setBool(_isLoggedInKey, true);
  }

  // 현재 로그인한 사용자 가져오기
  UserModel? getCurrentUser() {
    final userJson = _preferences.getString(_currentUserKey);
    if (userJson == null) return null;
    return UserModel.fromJson(json.decode(userJson));
  }

  // 로그인 상태 확인
  bool isLoggedIn() {
    return _preferences.getBool(_isLoggedInKey) ?? false;
  }

  // 로그아웃
  Future<void> logout() async {
    await _preferences.remove(_currentUserKey);
    await _preferences.setBool(_isLoggedInKey, false);
  }

  // 사용자 등록 (회원가입)
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String dateOfBirth,
    required String password,
  }) async {
    // 기존 사용자 목록 가져오기
    final usersJson = _preferences.getString(_usersKey);
    Map<String, dynamic> users = {};
    if (usersJson != null) {
      users = Map<String, dynamic>.from(json.decode(usersJson));
    }

    // 이메일 중복 확인
    if (users.containsKey(email)) {
      throw Exception('Email already exists');
    }

    // 새 사용자 생성
    final newUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      dateOfBirth: dateOfBirth,
      isVerified: true, // 실제로는 인증 후 true로 변경
    );

    // 사용자 정보와 비밀번호 저장
    users[email] = {
      'user': newUser.toJson(),
      'password': password, // 실제로는 암호화해야 함
    };

    await _preferences.setString(_usersKey, json.encode(users));

    return newUser;
  }

  // 로그인
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final usersJson = _preferences.getString(_usersKey);
    if (usersJson == null) {
      throw Exception('No users found');
    }

    final users = Map<String, dynamic>.from(json.decode(usersJson));

    if (!users.containsKey(email)) {
      throw Exception('User not found');
    }

    final userData = users[email];
    final storedPassword = userData['password'];

    if (storedPassword != password) {
      throw Exception('Invalid password');
    }

    return UserModel.fromJson(userData['user']);
  }

  // 사용자 정보 업데이트
  Future<void> updateUser(UserModel user) async {
    final usersJson = _preferences.getString(_usersKey);
    if (usersJson == null) return;

    final users = Map<String, dynamic>.from(json.decode(usersJson));

    if (users.containsKey(user.email)) {
      users[user.email]['user'] = user.toJson();
      await _preferences.setString(_usersKey, json.encode(users));

      // 현재 로그인한 사용자면 업데이트
      final currentUser = getCurrentUser();
      if (currentUser?.email == user.email) {
        await setCurrentUser(user);
      }
    }
  }
}
