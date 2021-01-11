import 'dart:convert';

import 'package:amadis_delivery/models/models.dart';

List<List<Order>> routesFromJson(String str) => List<List<Order>>.from(json
    .decode(str)
    .map((x) => List<Order>.from(x.map((x) => Order.fromJson(x)))));

String routesToJson(List<List<Order>> data) => json.encode(List<dynamic>.from(
    data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class Routes {
  Routes({
    this.isRouteActive = false,
    this.isRouteFinished = false,
    this.orders,
  });

  final bool isRouteActive;
  final bool isRouteFinished;
  final List<Order> orders;

  // Routes copyWith()
}
