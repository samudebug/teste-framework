part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class NotAuthorized extends AuthState {}

class Authorized extends AuthState {
  final User user;

  const Authorized(this.user);

  @override
  List<Object> get props => [user];
}
