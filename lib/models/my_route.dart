import 'dart:convert';

import 'package:amadis_delivery/models/models.dart';

List<MyRoute> routesFromJson(String str) =>
    List<MyRoute>.from(json.decode(str).map((x) => MyRoute.fromJson(x)));

// String routesToJson(List<List<Order>> data) => json.encode(List<dynamic>.from(
//     data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class MyRoute {
  MyRoute({
    this.isRouteActive = false,
    this.isRouteFinished = false,
    this.orders,
  });

  final bool isRouteActive;
  final bool isRouteFinished;
  final List<Order> orders;

  factory MyRoute.fromJson(dynamic x) => MyRoute(
        orders: List<Order>.from(x.map((e) => Order.fromJson(e))),
      );

  MyRoute copyWith({
    bool isRouteActive,
    bool isRouteFinished,
    List<Order> orders,
  }) =>
      MyRoute(
        isRouteActive: isRouteActive ?? this.isRouteActive,
        isRouteFinished: isRouteFinished ?? this.isRouteFinished,
        orders: orders ?? this.orders,
      );
}
