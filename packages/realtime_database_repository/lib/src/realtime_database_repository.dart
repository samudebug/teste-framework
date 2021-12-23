import 'package:firebase_database/firebase_database.dart';
import 'package:realtime_database_repository/src/interface_realtime_database_repository.dart';

class RealtimeDatabaseRepository implements IRealtimeDatabaseRepository {
  final FirebaseDatabase _database;
  RealtimeDatabaseRepository(app)
      : _database = FirebaseDatabase.instanceFor(app: app) {
    _database.goOnline();
  }

  @override
  DatabaseReference getRef(String path) {
    if (path.isEmpty) return _database.ref('').push();
    return _database.ref(path);
  }

  @override
  Stream<DatabaseEvent> listenToRef(String path) {
    DatabaseReference _ref = _database.ref(path);
    return _ref.onValue;
  }
}
