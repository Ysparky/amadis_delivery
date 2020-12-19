class Role {
  Role({
    this.id,
    this.name,
    this.permissions,
  });

  final int id;
  final String name;
  final List<String> permissions;

  Role copyWith({
    int id,
    String name,
    List<String> permissions,
  }) =>
      Role(
        id: id ?? this.id,
        name: name ?? this.name,
        permissions: permissions ?? this.permissions,
      );

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json['id'],
        name: json['name'],
        permissions: List<String>.from(json['permissions'].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'permissions': List<dynamic>.from(permissions.map((x) => x)),
      };
}
