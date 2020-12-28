import 'package:amadis_delivery/core/utils/data.dart';
import 'package:amadis_delivery/models/category.dart';

class Product {
  const Product({
    this.id,
    this.name,
    this.description,
    this.category,
  });

  final int id;
  final String name;
  final String description;
  final Category category;

  Product copyWith({
    int id,
    String name,
    String description,
    Category category,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        category: category ?? this.category,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        category: categories.singleWhere((c) => c.id == json['categoryId']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'categoryId': category.id,
      };
}
