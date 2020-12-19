import 'package:amadis_delivery/features/home/home_page.dart';
import 'package:amadis_delivery/features/login/login_page.dart';
import 'package:amadis_delivery/features/take_order/take_order_page.dart';
import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route_annotations.dart';

@MaterialAutoRouter(
  routes: [
    AdaptiveRoute(page: LoginPage, initial: true),
    AdaptiveRoute(page: HomePage),
    AdaptiveRoute(page: TakeOrderPage),
  ],
)
class $CustomRouter {}

Widget fadeTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(opacity: animation, child: child);
}
