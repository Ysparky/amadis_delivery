class Presentation {
  Presentation({
    this.id,
    this.name,
    this.description,
  });

  final int id;
  final String name;
  final String description;

  Presentation copyWith({
    int id,
    String name,
    String description,
  }) =>
      Presentation(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
      );

  factory Presentation.fromJson(Map<String, dynamic> json) => Presentation(
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
