// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';

import '../../features/dashboard/dashboard_page.dart';
import '../../features/list_orders/list_orders.dart';
import '../../features/login/login_page.dart';
import '../../features/take_order/take_order_page.dart';

class Routes {
  static const String loginPage = '/';
  static const String dashboardPage = '/dashboard-page';
  static const String takeOrderPage = '/take-order-page';
  static const String listOrdersPage = '/list-orders-page';
  static const all = <String>{
    loginPage,
    dashboardPage,
    takeOrderPage,
    listOrdersPage,
  };
}

class CustomRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loginPage, page: LoginPage),
    RouteDef(Routes.dashboardPage, page: DashboardPage),
    RouteDef(Routes.takeOrderPage, page: TakeOrderPage),
    RouteDef(Routes.listOrdersPage, page: ListOrdersPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    LoginPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => LoginPage(),
        settings: data,
      );
    },
    DashboardPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => DashboardPage(),
        settings: data,
      );
    },
    TakeOrderPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => TakeOrderPage(),
        settings: data,
      );
    },
    ListOrdersPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ListOrdersPage(),
        settings: data,
      );
    },
  };
}
