part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthUpdate extends AuthEvent {
  final User? user;

  const AuthUpdate(this.user);
}

class Login extends AuthEvent {
  final Credentials credentials;
  const Login(this.credentials);

  @override
  List<Object> get props => [credentials];
}

class Logout extends AuthEvent {}
