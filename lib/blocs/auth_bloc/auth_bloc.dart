import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(IAuthenticationRepository repository)
      : _repository = repository,
        super(AuthInitial()) {
    _repository.authState!.listen((value) {
      add(AuthUpdate(value));
    });
    on<Login>((event, emit) {
      _repository.login(event.credentials);
    });
    on<Logout>((event, emit) {
      _repository.logout();
    });
    on<AuthUpdate>((event, emit) {
      if (event.user == null) {
        emit(NotAuthorized());
      } else {
        emit(Authorized(event.user!));
      }
    });
  }

  late final IAuthenticationRepository _repository;
}
