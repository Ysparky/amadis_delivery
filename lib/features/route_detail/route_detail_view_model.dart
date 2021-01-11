import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/features/route_detail/route_detail_page.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/services/order_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class RouteDetailViewModel extends AmadisViewModel {
  RouteDetailViewModel(this.orderList) {
    var index = orderList.indexWhere((order) => order.isRouteActive);
    if (index == -1) {
      orderList[0] = orderList[0].copyWith(isRouteActive: true);
    }
    _updateStepsList();
    _orderService.selectedOrder.add(orderList);
  }

  final _orderService = injector<OrderService>();

  final List<Order> orderList;

  List<Step> stepsList = [];

  int currentStep = 0;

  void _updateStepsList() {
    var index = orderList.indexWhere((order) => order.isRouteActive);
    if (index != -1) {
      stepsList = orderList.asMap().entries.map((e) {
        var idx = e.key;
        var order = e.value;
        return Step(
          title: idx == index
              ? OrderItem(order: order)
              : InactiveOrderItem(order: order),
          content: Container(),
          isActive: idx == index ? true : false,
        );
      }).toList();
    } else {
      // route not initialized
      stepsList = orderList
          .map((order) => Step(
                title: InactiveOrderItem(order: order),
                content: Container(),
              ))
          .toList();
    }
  }

  void goToDetail(Order order) => ExtendedNavigator.root.push(
        Routes.orderDetailPage,
        arguments: OrderDetailPageArguments(order: order),
      );

  @override
  void dispose() {
    // _orderService.selectedOrder.add(null);
    super.dispose();
  }
}
