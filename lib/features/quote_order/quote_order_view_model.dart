import 'package:amadis_delivery/core/widgets/widgets.dart';
import 'package:amadis_delivery/networking/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/utils/service_injector.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuoteOrderViewModel extends AmadisViewModel {
  QuoteOrderViewModel({
    this.order,
    this.subtotalPrice,
    this.boxCharges,
    this.bottleCharges,
    this.consumedList,
  });

  final Order order;
  final List<OrderDetail> consumedList;
  final double subtotalPrice;
  final double boxCharges;
  final double bottleCharges;

  final ScrollController scrollController = ScrollController();

  final _orderService = injector<OrderService>();

  int getQtyByDetail(OrderDetail detail) {
    var index = consumedList.indexWhere((d) =>
        d.productPresentation.product.name ==
        detail.productPresentation.product.name);
    return index != -1 ? consumedList[index].quantity : 0;
  }

  double getSubtotalByDetail(OrderDetail detail) {
    var index = consumedList.indexWhere((d) =>
        d.productPresentation.product.name ==
        detail.productPresentation.product.name);
    return index != -1 ? consumedList[index].totalPrice : 0.00;
  }

  Future<void> postAdditionalCharges() async {
    setLoading(true);

    final response = await _orderService.additionalCharges(order, consumedList);
    await _orderService.getOrders();
    setLoading(false);
    if (response == null || !response) {
      showErrorSnackBar('Ocurrió un error');
    } else {
      _showSuccessQuote();
    }
  }

  void _handleRoutes() async {
    var selectedRoute = _orderService.selectedRoute.value;
    //go to next step if not the last one
    final ordersQty = selectedRoute.orders.length;

    //get the active order idx from the route
    final activeOrderIdx =
        selectedRoute.orders.indexWhere((order) => order.isOrderActive);

    selectedRoute.orders[activeOrderIdx] =
        selectedRoute.orders[activeOrderIdx].copyWith(
      isOrderActive: false,
      isOrderDelivered: true,
    );
    final nextIdx = activeOrderIdx + 1;
    if (ordersQty != nextIdx) {
      selectedRoute.orders[nextIdx] =
          selectedRoute.orders[nextIdx].copyWith(isOrderActive: true);
      ExtendedNavigator.root.popUntilRoot();
      await ExtendedNavigator.root.push(
        Routes.routeDetailPage,
        arguments: RouteDetailPageArguments(selectedRoute: selectedRoute),
      );
    } else {
      selectedRoute = selectedRoute.copyWith(
        isRouteActive: false,
        isRouteFinished: true,
      );

      var myRoutes = _orderService.routes.value.data;
      var index = _orderService.selectedRouteIndex.value;
      myRoutes[index] = selectedRoute;

      _orderService.routes.add(ApiResponse.completed(myRoutes));
      _orderService.selectedRoute.add(null);
      _orderService.selectedRouteIndex.add(null);
      await _showSuccessDelivery();
    }
  }

  double calculateTotalPrice() {
    var _totalPrice = subtotalPrice + boxCharges + bottleCharges;
    return _totalPrice;
  }

  void _showSuccessQuote() async {
    await showDialog(
      context: scaffoldKey.currentContext,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: CustomModal(
          showCloseButton: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(AmadisAssets.svg_check_mark, height: hp(10)),
              SizedBox(height: hp(2.0)),
              Text(
                '¡La cotización se ha realizado con éxito!',
                style: Theme.of(scaffoldKey.currentContext)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: hp(2.0)),
              SizedBox(
                width: wp(35),
                child: CustomButton(
                  onPressed: _handleRoutes,
                  text: 'ACEPTAR',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDelivery() async {
    await showDialog(
      context: scaffoldKey.currentContext,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: CustomModal(
          showCloseButton: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AmadisAssets.success_delivery, height: hp(10)),
              SizedBox(height: hp(2.0)),
              Text(
                '¡Se han completado todos los pedidos de la ruta!',
                textAlign: TextAlign.center,
                style: Theme.of(scaffoldKey.currentContext)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: hp(2.0)),
              SizedBox(
                width: wp(35),
                child: CustomButton(
                  onPressed: () {
                    ExtendedNavigator.root.popUntilRoot();
                  },
                  text: 'ACEPTAR',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
