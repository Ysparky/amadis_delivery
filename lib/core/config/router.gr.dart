// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../../features/additional_charges/cash_order/cash_order_page.dart';
import '../../features/additional_charges/consignment_order/consignment_order_page.dart';
import '../../features/dashboard/dashboard_page.dart';
import '../../features/list_orders/list_orders_page.dart';
import '../../features/login/login_page.dart';
import '../../features/order_detail/order_detail_page.dart';
import '../../features/take_order/take_order_page.dart';
import '../../features/welcome/welcome_page.dart';
import '../../models/models.dart';

class Routes {
  static const String welcomePage = '/';
  static const String loginPage = '/login-page';
  static const String dashboardPage = '/dashboard-page';
  static const String takeOrderPage = '/take-order-page';
  static const String listOrdersPage = '/list-orders-page';
  static const String orderDetailPage = '/order-detail-page';
  static const String cashOrderPage = '/cash-order-page';
  static const String consignmentOrderPage = '/consignment-order-page';
  static const all = <String>{
    welcomePage,
    loginPage,
    dashboardPage,
    takeOrderPage,
    listOrdersPage,
    orderDetailPage,
    cashOrderPage,
    consignmentOrderPage,
  };
}

class CustomRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.welcomePage, page: WelcomePage),
    RouteDef(Routes.loginPage, page: LoginPage),
    RouteDef(Routes.dashboardPage, page: DashboardPage),
    RouteDef(Routes.takeOrderPage, page: TakeOrderPage),
    RouteDef(Routes.listOrdersPage, page: ListOrdersPage),
    RouteDef(Routes.orderDetailPage, page: OrderDetailPage),
    RouteDef(Routes.cashOrderPage, page: CashOrderPage),
    RouteDef(Routes.consignmentOrderPage, page: ConsignmentOrderPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    WelcomePage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => WelcomePage(),
        settings: data,
      );
    },
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
    OrderDetailPage: (data) {
      final args = data.getArgs<OrderDetailPageArguments>(
        orElse: () => OrderDetailPageArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => OrderDetailPage(
          key: args.key,
          order: args.order,
        ),
        settings: data,
      );
    },
    CashOrderPage: (data) {
      final args = data.getArgs<CashOrderPageArguments>(
        orElse: () => CashOrderPageArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => CashOrderPage(
          key: args.key,
          order: args.order,
        ),
        settings: data,
      );
    },
    ConsignmentOrderPage: (data) {
      final args = data.getArgs<ConsignmentOrderPageArguments>(
        orElse: () => ConsignmentOrderPageArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ConsignmentOrderPage(
          key: args.key,
          order: args.order,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// OrderDetailPage arguments holder class
class OrderDetailPageArguments {
  final Key key;
  final Order order;
  OrderDetailPageArguments({this.key, this.order});
}

/// CashOrderPage arguments holder class
class CashOrderPageArguments {
  final Key key;
  final Order order;
  CashOrderPageArguments({this.key, this.order});
}

/// ConsignmentOrderPage arguments holder class
class ConsignmentOrderPageArguments {
  final Key key;
  final Order order;
  ConsignmentOrderPageArguments({this.key, this.order});
}
