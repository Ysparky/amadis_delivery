import 'package:amadis_delivery/models/models.dart';

class ProductPresentation {
  ProductPresentation({
    this.id,
    this.price,
    this.imageUrl =
        'https://www.laparadavirtual.com/public/uploads/products/thumbnail/FGVyLNocJ24bdrfqHbAtipBnRGCwtTxzIFkTfioq.jpeg',
    this.product,
    this.presentation,
  });

  final int id;
  final double price;
  final String imageUrl;
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
        price: double.parse(json['price']),
        imageUrl: json['pathImage'],
        product: Product.fromJson(json['product']),
        presentation: Presentation.fromJson(json['presentation']),
      );
}
