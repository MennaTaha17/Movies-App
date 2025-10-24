import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// --------------------------
  /// Sign Up a new user
  /// --------------------------
  static Future<UserModel?> signUpWithEmail(UserModel userModel, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: password,
      );

      userModel.uid = credential.user!.uid;

      await _firestore.collection("users").doc(userModel.uid).set(userModel.toJson());

      return userModel;
    } on FirebaseAuthException catch (e) {
      String message = _getFirebaseAuthErrorMessage(e.code);
      throw Exception(message);
    } catch (e) {
      throw Exception("Unexpected error occurred while signing up. Please try again.");
    }
  }

  /// --------------------------
  /// Login user
  /// --------------------------
  static Future<User?> logInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      String message = _getFirebaseAuthErrorMessage(e.code);
      throw Exception(message);
    } catch (e) {
      throw Exception("Unexpected error occurred while logging in. Please try again.");
    }
  }

  /// --------------------------
  /// Get current user info
  /// --------------------------
  static Future<UserModel?> getCurrentUserInfo() async {
    String? uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    DocumentSnapshot<Map<String, dynamic>> doc =
    await _firestore.collection("users").doc(uid).get();

    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }

  /// --------------------------
  /// Logout
  /// --------------------------
  static Future<void> logOut() async {
    await _auth.signOut();
  }

  /// --------------------------
  /// Convert FirebaseAuthException codes to readable messages
  /// --------------------------
  static String _getFirebaseAuthErrorMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return "Invalid email address.";
      case 'user-disabled':
        return "This account has been disabled.";
      case 'user-not-found':
        return "User not found.";
      case 'wrong-password':
        return "Incorrect password.";
      case 'email-already-in-use':
        return "Email is already in use.";
      case 'weak-password':
        return "Weak password. Use at least 6 characters.";
      default:
        return "Unexpected error occurred. Please try again.";
    }
  }

  sendPasswordResetEmail(String email) {}
}
