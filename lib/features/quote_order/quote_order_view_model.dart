import 'package:amadis_delivery/core/widgets/widgets.dart';
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
  final _prefs = SharedPrefs();

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
    // final response = await _orderService.additionalCharges(order, consumedList);
    await _orderService.getOrders();
    setLoading(false);
    // if (response == null || !response) {
    // showErrorSnackBar('Ocurrió un error');
    // } else {
    _showSuccessQuote();
    // }
  }

  void _handleRoutes() async {
    var orderList = _orderService.selectedOrder.value;
    var activeIndex = orderList.indexWhere((order) => order.isRouteActive);
    orderList[activeIndex] =
        orderList[activeIndex].copyWith(isRouteActive: false);
    if ((activeIndex + 1) == orderList.length) {
      print('ended route');
      _prefs.activeRouteIndex = -1;
      _orderService.selectedOrder.add(null);
      await _showSuccessDelivery();
    } else {
      print('road to next stop');
      final nextIdx = activeIndex + 1;
      orderList[nextIdx] = orderList[nextIdx].copyWith(isRouteActive: true);
      orderList.forEach((element) {
        print(element.isRouteActive);
      });

      ExtendedNavigator.root.popUntil(ModalRoute.withName(Routes.routesPage));
      await ExtendedNavigator.root.push(
        Routes.routeDetailPage,
        arguments: RouteDetailPageArguments(
          orderList: orderList,
        ),
      );
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
                    ExtendedNavigator.root
                        .popUntil(ModalRoute.withName(Routes.routesPage));
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
