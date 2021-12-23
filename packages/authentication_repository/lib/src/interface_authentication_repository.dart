import 'package:authentication_repository/src/model/credentials.dart';
import 'package:authentication_repository/src/model/user.dart';

abstract class IAuthenticationRepository {
  Future<void> login(Credentials credentials);
  Future<void> logout();
  Stream<User?>? authState;
}
