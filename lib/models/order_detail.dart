import 'package:amadis_delivery/models/presentation.dart';
import 'package:amadis_delivery/models/product.dart';
import 'package:amadis_delivery/models/product_presentation.dart';

class OrderDetail {
  OrderDetail({
    this.id,
    this.quantity,
    this.orderId,
    this.totalPrice,
    this.missingBoxQtys = 0,
    this.productPresentation,
  });

  final int id;
  final int quantity;
  final int orderId;
  final double totalPrice;
  final int missingBoxQtys;
  final ProductPresentation productPresentation;

  OrderDetail copyWith({
    int id,
    int quantity,
    int orderId,
    int productId,
    double totalPrice,
    ProductPresentation productPresentation,
    int missingBoxQtys,
  }) =>
      OrderDetail(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        orderId: orderId ?? this.orderId,
        totalPrice: totalPrice ?? this.totalPrice,
        missingBoxQtys: missingBoxQtys ?? this.missingBoxQtys,
        productPresentation: productPresentation ?? this.productPresentation,
      );

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json['id'],
        productPresentation: ProductPresentation(
          price: double.parse(json['unitPrice']),
          presentation: Presentation(name: json['presentation']),
          product: Product(name: json['product']),
        ),
        quantity: json['quantity'],
        totalPrice: json['quantity'] * double.parse(json['unitPrice']),
      );

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'productPresentationId': productPresentation.id,
      };

  Map<String, dynamic> toReamingJson() => {
        'orderDetailId': id,
        'quantityRemaining': quantity,
      };
}
