class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final List<String> assignedOperations;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.assignedOperations,
    required this.createdAt,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    UserRole? role,
    List<String>? assignedOperations,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      assignedOperations: assignedOperations ?? this.assignedOperations,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.toString().split('.').last,
      'assignedOperations': assignedOperations,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: UserRole.values.firstWhere(
        (e) => e.toString().split('.').last == json['role'],
        orElse: () => UserRole.user,
      ),
      assignedOperations: List<String>.from(json['assignedOperations'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

enum UserRole { admin, user, operator }
