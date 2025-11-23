import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/model/user_model.dart';

class AuthServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<UserModel?> signUpWithEmail(
    UserModel userModel,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: userModel.email,
            password: password,
          );
      String uid = credential.user!.uid;
      userModel.uid = uid;

      await _addUser(userModel);
      return userModel;
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.message}');
      return null;
    }
  }

  static Future<User?> LogInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.message}');
      return null;
    }
  }

  static CollectionReference<UserModel> _getUserCollection() {
    CollectionReference<UserModel> users = FirebaseFirestore.instance
        .collection('users')
        .withConverter<UserModel>(
          fromFirestore:
              (snapshot, options) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
    return users;
  }

  static _addUser(UserModel user) async {
    CollectionReference<UserModel> userCollection = _getUserCollection();
    DocumentReference<UserModel> doc = userCollection.doc(user.uid);
    await doc.set(user);
  }

  static Future<UserModel?> getUserInfo() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;
    CollectionReference<UserModel> userCollection = _getUserCollection();
    DocumentReference<UserModel> doc = userCollection.doc(uid);
    DocumentSnapshot<UserModel> snapshot = await doc.get();
    UserModel? user = snapshot.data();
    return user;
  }

  static Future<void> deleteUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No user is currently signed in.',
        );
      }
      CollectionReference<UserModel> userCollection = _getUserCollection();
      DocumentReference<UserModel> doc = userCollection.doc(user.uid);
      await doc.delete();
      await user.delete();
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> updateUserData({
    required String name,
    required String phone,
  }) async {

    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid == null) return;

    CollectionReference<UserModel> userCollection = _getUserCollection();
    DocumentReference<UserModel> doc = userCollection.doc(uid);

    await doc.update({
      "name": name,
      "phone": phone,
    });
  }

}
