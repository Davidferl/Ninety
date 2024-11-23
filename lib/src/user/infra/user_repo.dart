import 'package:bonne_reponse/src/exceptions/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/user.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUser(User user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.id)
          .set(user.toJson(), SetOptions(merge: true));
    } on Exception catch (e) {
      print(e);
      throw const FirestoreException(
        message: 'Something went wrong. Please try again later.',
      );
    }
  }

  Future<User> getUserById(String userId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) {
        throw const FirestoreException(
          message: 'User not found.',
        );
      }
      return User.fromJson(userDoc.data()!);
    } on Exception catch (e) {
      print(e);
      throw const FirestoreException(
        message: 'Something went wrong. Please try again later.',
      );
    }
  }

  Future<List<User>> getAllUsers() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> users =
          await _firestore.collection('users').get();
      return users.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> user) =>
              User.fromJson(user.data()))
          .toList();
    } on Exception catch (e) {
      print(e);
      throw const FirestoreException(
        message: 'Something went wrong. Please try again later.',
      );
    }
  }
}
