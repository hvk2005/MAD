import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../models/user.dart' as app_user;
import '../constants/app_constants.dart';

class AuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<app_user.User?> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final userDoc =
            await _firestore
                .collection(AppConstants.usersCollection)
                .doc(userCredential.user!.uid)
                .get();

        if (userDoc.exists) {
          final userData = userDoc.data() as Map<String, dynamic>;
          final user = app_user.User(
            id: userCredential.user!.uid,
            email: userData['email'],
            name: userData['name'],
            role: app_user.UserRole.values.firstWhere(
              (role) => role.toString() == 'UserRole.${userData['role']}',
            ),
            assignedOperations: List<String>.from(
              userData['assignedOperations'] ?? [],
            ),
          );

          // Save user to Hive for offline access
          final userBox = await Hive.openBox<app_user.User>(
            AppConstants.userBox,
          );
          await userBox.put('current_user', user);

          return user;
        }
      }
      return null;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      final userBox = await Hive.openBox<app_user.User>(AppConstants.userBox);
      await userBox.delete('current_user');
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  Future<app_user.User?> getCurrentUser() async {
    try {
      final userBox = await Hive.openBox<app_user.User>(AppConstants.userBox);
      return userBox.get('current_user');
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  Future<bool> isAuthenticated() async {
    try {
      final userBox = await Hive.openBox<app_user.User>(AppConstants.userBox);
      return userBox.get('current_user') != null;
    } catch (e) {
      return false;
    }
  }
}
