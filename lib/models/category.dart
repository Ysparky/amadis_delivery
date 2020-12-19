class Category {
  const Category({
    this.id,
    this.name,
    this.description,
  });

  final int id;
  final String name;
  final String description;

  Category copyWith({
    int id,
    String name,
    String description,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
      };
}
