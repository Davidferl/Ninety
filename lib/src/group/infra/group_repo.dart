import 'dart:io';

import 'package:bonne_reponse/src/exceptions/exceptions.dart';
import 'package:bonne_reponse/src/group/domain/group.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class GroupRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firestoreStorage = FirebaseStorage.instance;

  Future<String> uploadImage(XFile image) async {
    try {
      final storageRef =
          _firestoreStorage.ref().child('uploads/groups/${image.name}');
      File fileToUpload = File(image.path);
      await storageRef.putFile(fileToUpload);
      return await storageRef.getDownloadURL();
    } catch (e) {
      throw const FirestoreException(
        message: 'Image upload for group failed.',
      );
    }
  }

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
      print("Error: $e");
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
