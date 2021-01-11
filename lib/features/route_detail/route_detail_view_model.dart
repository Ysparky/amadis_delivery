import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/features/route_detail/route_detail_page.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/services/order_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class RouteDetailViewModel extends AmadisViewModel {
  RouteDetailViewModel(this.orderList, this.routeIndex) {
    print(activeRouteIndex);
    print(routeActiveIdx);
    if (activeRouteIndex == -1) {
      _initRoute();
    } else {
      final index = routeActiveIdx;
      currentStep = index + 1;
      _updateRouteStep(index);
    }
    _orderService.selectedOrder.add(orderList);
    // print(currentStep);
  }

  final List<Order> orderList;
  final int routeIndex;

  final _orderService = injector<OrderService>();
  final _prefs = SharedPrefs();

  List<Step> stepsList = [];

  int get routeActiveIdx =>
      orderList.indexWhere((order) => order.isRouteActive);

  int get stepActiveIdx => stepsList.indexWhere((step) => step.isActive);

  int currentStep = 0;

  int get activeRouteIndex => _prefs.activeRouteIndex;

  void _initRoute() {
    currentStep = 0;
    stepsList = [
      Step(
        title: LocalStep(),
        content: Container(),
        isActive: true,
      ),
      ...orderList
          .map((order) => Step(
                title: InactiveOrderItem(order: order),
                content: Container(),
              ))
          .toList(),
    ];
  }

  void _updateRouteStep(int index) {
    stepsList = [
      Step(
        title: LocalStep(),
        content: Container(),
        isActive: false,
      ),
      ...orderList.asMap().entries.map((e) {
        var idx = e.key;
        var order = e.value;
        return Step(
          title: idx == index
              ? OrderItem(order: order)
              : InactiveOrderItem(order: order),
          content: Container(),
          isActive: idx == index ? true : false,
        );
      }).toList()
    ];

    notifyListeners();
  }

  void goToDetail(Order order) => ExtendedNavigator.root.push(
        Routes.orderDetailPage,
        arguments: OrderDetailPageArguments(order: order),
      );

  void startRoute() {
    print('xddd');
    // save the index from the list of routes
    _prefs.activeRouteIndex = routeIndex;

    orderList.first = orderList.first.copyWith(isRouteActive: true);
    currentStep = 1;
    _updateRouteStep(0);
  }
}
