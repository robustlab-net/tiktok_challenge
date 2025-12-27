class SignUpDataModel {
  final String name;
  final String email;
  final String dateOfBirth;
  final String? verificationCode;
  final String? password;

  SignUpDataModel({
    required this.name,
    required this.email,
    required this.dateOfBirth,
    this.verificationCode,
    this.password,
  });

  SignUpDataModel copyWith({
    String? name,
    String? email,
    String? dateOfBirth,
    String? verificationCode,
    String? password,
  }) {
    return SignUpDataModel(
      name: name ?? this.name,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      verificationCode: verificationCode ?? this.verificationCode,
      password: password ?? this.password,
    );
  }
}
