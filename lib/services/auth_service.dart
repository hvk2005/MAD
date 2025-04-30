import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart' as app_user;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<app_user.User?> signIn(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        final userDoc =
            await _firestore.collection('users').doc(result.user!.uid).get();
        if (userDoc.exists) {
          return app_user.User.fromJson(userDoc.data()!);
        }
      }
      return null;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  Future<app_user.User?> signUp(
      String email, String password, String name) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        final user = app_user.User(
          id: result.user!.uid,
          name: name,
          email: email,
          role: app_user.UserRole.user,
          assignedOperations: [],
          createdAt: DateTime.now(),
        );

        await _firestore
            .collection('users')
            .doc(result.user!.uid)
            .set(user.toJson());
        return user;
      }
      return null;
    } catch (e) {
      print('Error signing up: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<app_user.User?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        return app_user.User.fromJson(userDoc.data()!);
      }
    }
    return null;
  }
}
