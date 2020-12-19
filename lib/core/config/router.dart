import 'package:amadis_delivery/features/order_detail/order_detail_page.dart';
import 'package:flutter/widgets.dart';

import 'package:amadis_delivery/features/dashboard/dashboard_page.dart';
import 'package:amadis_delivery/features/list_orders/list_orders_page.dart';
import 'package:amadis_delivery/features/login/login_page.dart';
import 'package:amadis_delivery/features/take_order/take_order_page.dart';
import 'package:amadis_delivery/features/welcome/welcome_page.dart';

import 'package:auto_route/auto_route_annotations.dart';

@MaterialAutoRouter(
  routes: [
    AdaptiveRoute(page: WelcomePage, initial: true),
    AdaptiveRoute(page: LoginPage),
    AdaptiveRoute(page: DashboardPage),
    AdaptiveRoute(page: TakeOrderPage),
    AdaptiveRoute(page: ListOrdersPage),
    AdaptiveRoute(page: OrderDetailPage),
  ],
)
class $CustomRouter {}

Widget fadeTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(opacity: animation, child: child);
}
