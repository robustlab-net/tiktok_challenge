import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_challenge/features/authentication/models/signup_data_model.dart';

class SignUpViewModel extends StateNotifier<SignUpDataModel?> {
  SignUpViewModel() : super(null);

  void setSignUpData({
    required String name,
    required String email,
    required String dateOfBirth,
  }) {
    state = SignUpDataModel(
      name: name,
      email: email,
      dateOfBirth: dateOfBirth,
    );
  }

  void setVerificationCode(String code) {
    if (state != null) {
      state = state!.copyWith(verificationCode: code);
    }
  }

  void setPassword(String password) {
    if (state != null) {
      state = state!.copyWith(password: password);
    }
  }

  void clear() {
    state = null;
  }
}

final signUpDataProvider =
    StateNotifierProvider<SignUpViewModel, SignUpDataModel?>((ref) {
  return SignUpViewModel();
});
