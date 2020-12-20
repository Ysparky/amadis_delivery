import 'package:amadis_delivery/core/config/view_model.dart';
import 'package:amadis_delivery/core/utils/service_injector.dart';
import 'package:amadis_delivery/models/order.dart';
import 'package:amadis_delivery/services/order_service.dart';

class ListOrdersViewModel extends AmadisViewModel {
  ListOrdersViewModel() {
    orderService.getOrders();
  }

  final orderService = injector<OrderService>();

  Stream<List<Order>> get orders => orderService.orders;

  // List<Order> _orders = [];
  // List<Order> get orders => _orders;

  Future<void> getOrders() async {
    // setLoading(true);
    // _orders = await _orderService.getOrders();
    // orders.
    notifyListeners();
    // setLoading(false);
  }
}
