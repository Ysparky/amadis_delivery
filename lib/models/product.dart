import 'package:amadis_delivery/models/category.dart';

class Product {
  const Product({
    this.id,
    this.name,
    this.price,
    this.description,
    this.category,
  });

  final int id;
  final String name;
  final double price;
  final String description;
  final Category category;

  Product copyWith({
    int id,
    String name,
    double price,
    String description,
    Category category,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        description: description ?? this.description,
        category: category ?? this.category,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json['product'],
        price: double.parse(json['unitPrice']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'description': description,
        'categoryId': category.id,
      };
}
