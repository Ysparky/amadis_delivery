// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';

import '../../features/home/home_page.dart';
import '../../features/login/login_page.dart';
import '../../features/take_order/take_order_page.dart';

class Routes {
  static const String loginPage = '/';
  static const String homePage = '/home-page';
  static const String takeOrderPage = '/take-order-page';
  static const all = <String>{
    loginPage,
    homePage,
    takeOrderPage,
  };
}

class CustomRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loginPage, page: LoginPage),
    RouteDef(Routes.homePage, page: HomePage),
    RouteDef(Routes.takeOrderPage, page: TakeOrderPage),
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
    HomePage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => HomePage(),
        settings: data,
      );
    },
    TakeOrderPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => TakeOrderPage(),
        settings: data,
      );
    },
  };
}
