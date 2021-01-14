import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/features/route_detail/route_detail_page.dart';
import 'package:amadis_delivery/features/route_detail/widgets/widgets.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/networking/api_response.dart';
import 'package:amadis_delivery/services/order_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class RouteDetailViewModel extends AmadisViewModel {
  RouteDetailViewModel(this.selectedRoute) {
    if (!selectedRoute.isRouteActive &&
        !selectedRoute.isRouteFinished &&
        checkNoRouteActive()) {
      _initRoute();
    } else {
      print(orderActiveIdx);
      _updateStepRoute(orderActiveIdx);
      currentStep = orderActiveIdx + 1;
    }
    _orderService.selectedRoute.add(selectedRoute);
  }

  bool checkNoRouteActive() {
    final myRoutes = _orderService.routes.value.data;
    var noRouteActive = true;
    for (var route in myRoutes) {
      if (route.isRouteActive) {
        noRouteActive = false;
        break;
      }
    }
    return noRouteActive;
  }

  MyRoute selectedRoute;

  final _orderService = injector<OrderService>();
  // final _prefs = SharedPrefs();

  List<Step> stepsList = [];

  int get orderActiveIdx =>
      selectedRoute.orders.indexWhere((order) => order.isOrderActive);

  int get stepActiveIdx => stepsList.indexWhere((step) => step.isActive);

  int currentStep = 0;
  void goToDetail(Order order) => ExtendedNavigator.root.push(
        Routes.orderDetailPage,
        arguments: OrderDetailPageArguments(order: order),
      );

  void _initRoute() {
    stepsList = [
      Step(
        title: LocalStep(),
        content: Container(),
        isActive: true,
      ),
      ...selectedRoute.orders
          .map(
            (e) => Step(
              title: InactiveOrderItem(order: e),
              content: Container(),
            ),
          )
          .toList(),
    ];
  }

  void startRoute() {
    selectedRoute = selectedRoute.copyWith(
      isRouteActive: true,
      isRouteFinished: false,
    );
    selectedRoute.orders.first =
        selectedRoute.orders.first.copyWith(isOrderActive: true);
    currentStep = 1;
    _updateStepRoute(0);
  }

  void _updateStepRoute(int index) {
    stepsList = [
      Step(
        title: LocalStep(enabled: false),
        content: Container(),
        isActive: false,
        state: StepState.complete,
      ),
      ...selectedRoute.orders.asMap().entries.map((e) {
        final idx = e.key;
        final value = e.value;
        return Step(
          title: idx == index
              ? OrderItem(order: value)
              : InactiveOrderItem(order: value),
          content: Container(),
          isActive: idx == index,
          state:
              value.isOrderDelivered ? StepState.complete : StepState.indexed,
        );
      }).toList(),
    ];
    //TODO update local storage
    var myRoutes = _orderService.routes.value.data;
    var routeIdx = _orderService.selectedRouteIndex.value;
    print(
        'Active Selected Route deberia dar true: ${selectedRoute.isRouteActive}');
    print(
        'Finished Selected Route deberia dar false: ${selectedRoute.isRouteFinished}');
    myRoutes[routeIdx] = selectedRoute;
    _orderService.routes.add(ApiResponse.completed(myRoutes));
    _orderService.selectedRoute.add(selectedRoute);
    notifyListeners();
  }

  void showLegend() async {
    await showModalBottomSheet(
      context: scaffoldKey.currentContext,
      builder: (context) {
        return SafeArea(
            child: SingleChildScrollView(
          child: Container(
            child: Wrap(
              children: [
                Legend(),
              ],
            ),
          ),
        ));
      },
    );
  }
}
