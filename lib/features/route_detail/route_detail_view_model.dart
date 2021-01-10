import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/features/route_detail/route_detail_page.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class RouteDetailViewModel extends AmadisViewModel {
  RouteDetailViewModel(this.orderList) {
    _updateStepsList(0);
  }

  final List<Order> orderList;

  List<Step> stepsList = [];

  int currentStep = 0;

  void onStepTapped(int value) {
    currentStep = value;
    _updateStepsList(value);
    notifyListeners();
  }

  void _updateStepsList(int index) {
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
  }

  void goToDetail(Order order) => ExtendedNavigator.root.push(
        Routes.orderDetailPage,
        arguments: OrderDetailPageArguments(order: order),
      );
}
