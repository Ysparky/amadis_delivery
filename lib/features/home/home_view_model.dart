import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/networking/api_response.dart';
import 'package:amadis_delivery/services/order_service.dart';
import 'package:auto_route/auto_route.dart';

class HomeViewModel extends AmadisViewModel {
  HomeViewModel() {
    _getRoutes();
    _generateDates();
  }

  List<String> get daysOfWeek =>
      ['LUN', 'MAR', 'MIE', 'JUE', 'VIE', 'SAB', 'DOM'];

  List<int> days = [];

  Stream<ApiResponse<List<MyRoute>>> get myRoutes =>
      _orderService.routes.stream;

  int get today => DateTime.now().day;

  final _prefs = SharedPrefs();
  final _orderService = injector<OrderService>();

  void _getRoutes() async {
    setLoading(true);
    await _orderService.getRoutes();
    setLoading(false);
  }

  void _generateDates() {
    var monday = 0;
    if (DateTime.now().weekday > 1) {
      final counter = DateTime.now().weekday - 1;
      monday = DateTime.now().day - counter;
    } else {
      monday = DateTime.now().day;
    }
    var aux = monday;
    for (var i = 0; i < 7; i++) {
      days.add(aux);
      aux++;
    }
  }

  int routesLeft(List<MyRoute> routes) {
    if (routes != null) {
      final totalRoutesQty = routes.length;
      final completedRoutesQty = routes
          .where((route) => route.isRouteFinished || route.isRouteActive)
          .length;
      return totalRoutesQty - completedRoutesQty;
    } else {
      return 0;
    }
  }

  int ordersDeliveredQty(List<MyRoute> routes) {
    if (routes != null) {
      var qty = 0;
      for (var route in routes) {
        route.orders.forEach((order) {
          if (order.isOrderDelivered) {
            qty++;
          }
        });
      }
      return qty;
    } else {
      return 0;
    }
  }

  void logOut() {
    _prefs.removeAll();
    ExtendedNavigator.root.popAndPush(Routes.loginPage);
  }
}
