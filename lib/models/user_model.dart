import 'package:hive/hive.dart';

enum UserRole {
  admin,
  operator,
}

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final UserRole role;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final bool isActive;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.createdAt,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      role: UserRole.values.firstWhere(
        (role) => role.toString().split('.').last == json['role'],
      ),
      createdAt: DateTime.parse(json['createdAt']),
      isActive: json['isActive'] ?? true,
    );
  }

  bool get isAdmin => role == UserRole.admin;
  bool get isOperator => role == UserRole.operator;

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    UserRole? role,
    DateTime? createdAt,
    bool? isActive,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
