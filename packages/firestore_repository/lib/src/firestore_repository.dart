import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/src/interface_firestore_repository.dart';

class FirestoreRepository implements IFirestoreRepository {
  FirestoreRepository(app) {
    _firestore = FirebaseFirestore.instanceFor(app: app);
  }
  late FirebaseFirestore _firestore;
  @override
  Future<List<QueryDocumentSnapshot<Object?>>> getAllDocuments(
      String collectionName) async {
    CollectionReference collection = _firestore.collection(collectionName);
    QuerySnapshot querySnapshot = await collection.get();
    return querySnapshot.docs;
  }

  @override
  Future<DocumentSnapshot> getDocumentById(String collectionName, String id) {
    return _firestore.collection(collectionName).doc(id).get();
  }

  @override
  Future<List<QueryDocumentSnapshot<Object?>>> searchDocuments(
      String collectionName, String field, String value) async {
    CollectionReference collection = _firestore.collection(collectionName);

    return (await collection.where(field, isEqualTo: value).get()).docs;
  }
}
