import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/core/utils/service_injector.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/services/order_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

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

  Future<void> postAdditionalCharges() async {
    setLoading(true);
    final response = await _orderService.additionalCharges(order, consumedList);
    setLoading(false);
    if (response == null || !response) {
      showErrorSnackBar('Ocurrió un error');
    } else {
      showMessageSnackBar(
          'El pedido ha sizo cotizado y está esperando el pago');
      setLoading(true);
      await _orderService.getOrders();
      setLoading(false);
      ExtendedNavigator.root
          .popUntil(ModalRoute.withName(Routes.dashboardPage));
    }
  }
}
