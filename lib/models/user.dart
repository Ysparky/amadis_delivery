import 'package:amadis_delivery/models/role.dart';

class User {
  User({
    this.id,
    this.user,
    this.personId,
    this.roles,
  });

  int id;
  String user;
  int personId;
  List<Role> roles;
  String error;

  User.withError(String errorMessage) {
    error = errorMessage;
  }

  User copyWith({
    int id,
    String user,
    int personId,
    List<Role> roles,
  }) =>
      User(
        id: id ?? this.id,
        user: user ?? this.user,
        personId: personId ?? this.personId,
        roles: roles ?? this.roles,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        user: json['user'],
        personId: json['personId'],
        roles: List<Role>.from(json['roles'].map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user,
        'personId': personId,
        'roles': List<dynamic>.from(roles.map((x) => x.toJson())),
      };
}
