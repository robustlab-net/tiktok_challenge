import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_challenge/features/authentication/models/user_model.dart';
import 'package:tiktok_challenge/features/authentication/repositories/auth_repository.dart';

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  bool get isLoggedIn => user != null;

  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthViewModel(this._repository) : super(AuthState()) {
    // 앱 시작 시 로그인 상태 확인
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    if (_repository.isLoggedIn()) {
      final user = _repository.getCurrentUser();
      if (user != null) {
        state = state.copyWith(user: user);
      }
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _repository.signUp(
        email: email,
        password: password,
      );

      state = state.copyWith(user: user, isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _repository.login(
        email: email,
        password: password,
      );

      state = state.copyWith(user: user, isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = AuthState();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Auth Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// Auth ViewModel Provider
final authProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthViewModel(repository);
});
