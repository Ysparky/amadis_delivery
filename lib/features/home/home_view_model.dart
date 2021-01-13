import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/services/order_service.dart';
import 'package:auto_route/auto_route.dart';

class HomeViewModel extends AmadisViewModel {
  HomeViewModel() {
    _generateDates();
    _orderService.getRoutes();
  }

  List<String> get daysOfWeek =>
      ['LUN', 'MAR', 'MIE', 'JUE', 'VIE', 'SAB', 'DOM'];

  List<int> days = [];

  // Stream<ApiResponse<List<MyRoute>>> get routes => _orderService.routes;
  // Stream<int> get routesLength => _orderService.routes.value.data
  //     .where((element) => element.isRouteFinished);

  int get today => DateTime.now().day;

  final _prefs = SharedPrefs();
  final _orderService = injector<OrderService>();

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

  void logOut() {
    _prefs.removeAll();
    ExtendedNavigator.root.popAndPush(Routes.loginPage);
  }
}
