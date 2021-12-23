class Credentials {
  String username;
  String password;

  Credentials(this.username, this.password);

  Credentials copyWith({String? username, String? password}) {
    return Credentials(username ?? this.username, password ?? this.password);
  }
}
