class UserModel {
  final String id;
  final String name;
  final String email;
  final String dateOfBirth;
  final bool isVerified;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.dateOfBirth,
    this.isVerified = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'isVerified': isVerified,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      isVerified: json['isVerified'] as bool? ?? false,
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? dateOfBirth,
    bool? isVerified,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
