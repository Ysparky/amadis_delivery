import 'package:amadis_delivery/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Order {
  Order({
    this.id,
    this.orderStateId = 1,
    this.orderTypeId = 1,
    this.shippingDate,
    this.customer,
    this.contactNumber,
    this.customerId,
    this.location,
    this.ordersDetail,
    this.missingBottlesQuantity = 0,
    this.missingBoxQuantity = 0,
  });

  final int id;
  final int orderStateId;
  final int orderTypeId;
  final String shippingDate;
  final String customer;
  final String contactNumber;
  final int customerId;
  final Location location;
  final List<OrderDetail> ordersDetail;
  final int missingBottlesQuantity;
  final int missingBoxQuantity;

  Order copyWith({
    int id,
    int orderStateId,
    int orderTypeId,
    String shippingDate,
    String customer,
    String contactNumber,
    int customerId,
    Location location,
    List<OrderDetail> ordersDetail,
    int missingBottlesQuantity,
    int missingBoxQuantity,
  }) =>
      Order(
        id: id ?? this.id,
        orderStateId: orderStateId ?? this.orderStateId,
        orderTypeId: orderTypeId ?? this.orderTypeId,
        shippingDate: shippingDate ?? this.shippingDate,
        customer: customer ?? this.customer,
        contactNumber: contactNumber ?? this.contactNumber,
        customerId: customerId ?? this.customerId,
        location: location ?? this.location,
        ordersDetail: ordersDetail ?? this.ordersDetail,
        missingBottlesQuantity:
            missingBottlesQuantity ?? this.missingBottlesQuantity,
        missingBoxQuantity: missingBoxQuantity ?? this.missingBoxQuantity,
      );

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        orderStateId: json['orderStateId'],
        orderTypeId: json['orderTypeId'],
        shippingDate: json['shippingDate'],
        customer: json['customer'],
        contactNumber: json['contactNumber'],
        location: Location(
          address: json['address'],
          reference: json['reference'],
          coordinates: LatLng(
            double.parse(json['latitude']),
            double.parse(json['longitude']),
          ),
        ),
        ordersDetail: json['orderDetail'] == null
            ? null
            : List<OrderDetail>.from(
                json['orderDetail'].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'shippingDate': shippingDate,
        'customerId': customerId,
        'address': location?.address,
        'reference': location?.reference,
        'latitude': location.coordinates.latitude.toString(),
        'longitude': location.coordinates.longitude.toString(),
        'orderTypeId': orderTypeId ?? 1,
        'orderDetail': ordersDetail == null
            ? null
            : List<dynamic>.from(ordersDetail.map((x) => x.toJson())),
      };
}
