import 'package:firebase_database/firebase_database.dart';

abstract class IRealtimeDatabaseRepository {
  DatabaseReference getRef(String path);

  Stream<DatabaseEvent> listenToRef(String path);
}
