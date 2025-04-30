import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final UserRole role;

  @HiveField(4)
  final List<String> assignedOperations;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.assignedOperations = const [],
  });
}

@HiveType(typeId: 1)
enum UserRole {
  @HiveField(0)
  admin,
  
  @HiveField(1)
  operator
} 