import 'package:amadis_delivery/models/product.dart';

class OrderDetail {
  OrderDetail({
    this.id,
    this.quantity,
    this.orderId,
    this.product,
    this.totalPrice,
    this.missingBoxQtys = 0,
  });

  final int id;
  final int quantity;
  final int orderId;
  final Product product;
  final double totalPrice;
  final int missingBoxQtys;

  OrderDetail copyWith({
    int id,
    int quantity,
    int orderId,
    int productId,
    Product product,
    double totalPrice,
    int missingBoxQtys,
  }) =>
      OrderDetail(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        orderId: orderId ?? this.orderId,
        product: product ?? this.product,
        totalPrice: totalPrice ?? this.totalPrice,
        missingBoxQtys: missingBoxQtys ?? this.missingBoxQtys,
      );

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json['id'],
        product: Product(
          name: json['product'],
          price: double.parse(json['unitPrice']),
        ),
        quantity: json['quantity'],
        totalPrice: json['quantity'] * double.parse(json['unitPrice']),
      );

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'productId': product.id,
      };

  Map<String, dynamic> toReamingJson() => {
        'orderDetailId': id,
        'quantityRemaining': quantity,
      };
}
