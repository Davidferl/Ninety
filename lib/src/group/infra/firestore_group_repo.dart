import 'package:bonne_reponse/src/exceptions/exceptions.dart';
import 'package:bonne_reponse/src/group/domain/group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreGroupRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> save(Group group) async {
    try {
      await _firestore
          .collection('groups')
          .doc(group.groupId)
          .set(group.toJson(), SetOptions(merge: true));
      print("Upsert successful!");
    } catch (e) {
      throw const FirestoreException(
        message: 'Something went wrong. Please try again later.',
      );
    }
  }

  Future<List<Group>> getAll() async {
    try {
      final snapshot = await _firestore.collection('groups').get();
      return snapshot.docs.map((doc) => Group.fromJson(doc.data())).toList();
    } catch (e) {
      throw const FirestoreException(
        message: 'Failed to fetch groups. Please try again later.',
      );
    }
  }

  Future<Group> getById(String id) async {
    try {
      final snapshot = await _firestore.collection('groups').doc(id).get();

      if (!snapshot.exists) {
        throw const FirestoreException(
          message: 'Group not found. Please check the ID and try again.',
        );
      }

      return Group.fromJson(snapshot.data()!);
    } catch (e) {
      throw const FirestoreException(
        message: 'Failed to fetch the group. Please try again later.',
      );
    }
  }
}
