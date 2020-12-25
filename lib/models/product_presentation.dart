import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/models/presentation.dart';

class ProductPresentation {
  ProductPresentation({
    this.id,
    this.price,
    this.product,
    this.presentation,
  });

  final int id;
  final double price;
  final Product product;
  final Presentation presentation;

  ProductPresentation copyWith({
    int id,
    double price,
    Product product,
    Presentation presentation,
  }) =>
      ProductPresentation(
        id: id ?? this.id,
        price: price ?? this.price,
        product: product ?? this.product,
        presentation: presentation ?? this.presentation,
      );

  factory ProductPresentation.fromJson(Map<String, dynamic> json) =>
      ProductPresentation(
        id: json['id'],
        price: json['price'],
        product: Product.fromJson(json['product']),
        presentation: Presentation.fromJson(json['presentation']),
      );

  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "price": price,
  //     "product": product.toJson(),
  //     "presentation": presentation.toJson(),
  // };
}
