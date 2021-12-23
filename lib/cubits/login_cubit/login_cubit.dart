import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';

class LoginCubit extends Cubit<Credentials> {
  LoginCubit() : super(Credentials("", ""));

  void setUsername(String username) {
    emit(state.copyWith(username: username));
  }

  void setPassword(String password) {
    emit(state.copyWith(password: password));
  }
}
