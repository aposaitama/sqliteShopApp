class User {
  int? id;
  final String login;
  final String password;
  User({this.id, required this.login, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'], login: json['login'], password: json['password']);
  }
  Map<String, dynamic> toMap() => {
        'id': id,
        'login': login,
        'password': password,
      };
}
