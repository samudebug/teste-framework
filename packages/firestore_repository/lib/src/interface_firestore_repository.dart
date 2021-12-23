import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IFirestoreRepository {
  Future<List<QueryDocumentSnapshot>> getAllDocuments(String collectionName);
  Future<DocumentSnapshot> getDocumentById(String collectionName, String id);
  Future<List<QueryDocumentSnapshot>> searchDocuments(
      String collectionName, String field, String value);
}
