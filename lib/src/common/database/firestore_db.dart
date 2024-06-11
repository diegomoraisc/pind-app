import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDb {
  FirestoreDb._();
  static final FirestoreDb _instance = FirestoreDb._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static get() {
    return FirestoreDb._instance._firestore;
  }
}
