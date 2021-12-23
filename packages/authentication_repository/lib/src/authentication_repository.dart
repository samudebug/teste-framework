import 'dart:async';

import 'package:authentication_repository/src/interface_authentication_repository.dart';
import 'package:authentication_repository/src/model/user.dart';
import 'package:authentication_repository/src/model/credentials.dart';
import 'dart:developer' as developer;

class InvalidUserException implements Exception {}

class AuthenticationRepository implements IAuthenticationRepository {
  StreamController<User?> _controller = StreamController();
  @override
  Stream<User?>? get authState => _controller.stream;
  set authState(newValue) => developer.log("Set");
  @override
  Future<void> login(Credentials credentials) async {
    if (credentials.username == "login" && credentials.password == "password") {
      _controller.add(User("User"));
      return;
    }
    throw InvalidUserException();
  }

  @override
  Future<void> logout() {
    _controller.add(null);
    throw UnimplementedError();
  }
}
