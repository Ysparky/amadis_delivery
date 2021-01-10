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
import '../../features/quote_order/quote_order_page.dart';
import '../../features/routes/routes_page.dart';
import '../../features/take_order/select_customer/select_customer_page.dart';
import '../../features/take_order/shopping_bag/shopping_bag_page.dart';
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
  static const String quoteOrderPage = '/quote-order-page';
  static const String selectCustomerPage = '/select-customer-page';
  static const String shoppingBagPage = '/shopping-bag-page';
  static const String routesPage = '/routes-page';
  static const all = <String>{
    welcomePage,
    loginPage,
    dashboardPage,
    takeOrderPage,
    listOrdersPage,
    orderDetailPage,
    cashOrderPage,
    consignmentOrderPage,
    quoteOrderPage,
    selectCustomerPage,
    shoppingBagPage,
    routesPage,
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
    RouteDef(Routes.quoteOrderPage, page: QuoteOrderPage),
    RouteDef(Routes.selectCustomerPage, page: SelectCustomerPage),
    RouteDef(Routes.shoppingBagPage, page: ShoppingBagPage),
    RouteDef(Routes.routesPage, page: RoutesPage),
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
      final args = data.getArgs<DashboardPageArguments>(
        orElse: () => DashboardPageArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => DashboardPage(
          key: args.key,
          initialPage: args.initialPage,
        ),
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
    QuoteOrderPage: (data) {
      final args = data.getArgs<QuoteOrderPageArguments>(
        orElse: () => QuoteOrderPageArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => QuoteOrderPage(
          key: args.key,
          order: args.order,
          orderDetail: args.orderDetail,
          subtotalPrice: args.subtotalPrice,
          boxCharges: args.boxCharges,
          bottleCharges: args.bottleCharges,
        ),
        settings: data,
      );
    },
    SelectCustomerPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => SelectCustomerPage(),
        settings: data,
      );
    },
    ShoppingBagPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ShoppingBagPage(),
        settings: data,
      );
    },
    RoutesPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => RoutesPage(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// DashboardPage arguments holder class
class DashboardPageArguments {
  final Key key;
  final int initialPage;
  DashboardPageArguments({this.key, this.initialPage});
}

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

/// QuoteOrderPage arguments holder class
class QuoteOrderPageArguments {
  final Key key;
  final Order order;
  final List<OrderDetail> orderDetail;
  final double subtotalPrice;
  final double boxCharges;
  final double bottleCharges;
  QuoteOrderPageArguments(
      {this.key,
      this.order,
      this.orderDetail,
      this.subtotalPrice,
      this.boxCharges,
      this.bottleCharges});
}
