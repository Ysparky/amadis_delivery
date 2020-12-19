import 'package:amadis_delivery/features/dashboard/dashboard_page.dart';
import 'package:amadis_delivery/features/list_orders/list_orders.dart';
import 'package:amadis_delivery/features/login/login_page.dart';
import 'package:amadis_delivery/features/take_order/take_order_page.dart';
import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route_annotations.dart';

@MaterialAutoRouter(
  routes: [
    AdaptiveRoute(page: LoginPage, initial: true),
    AdaptiveRoute(page: DashboardPage, initial: true),
    AdaptiveRoute(page: TakeOrderPage),
    AdaptiveRoute(page: ListOrdersPage),
  ],
)
class $CustomRouter {}

Widget fadeTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(opacity: animation, child: child);
}
