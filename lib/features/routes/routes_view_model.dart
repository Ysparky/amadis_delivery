import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/services/order_service.dart';
import 'package:auto_route/auto_route.dart';

class RoutesViewModel extends AmadisViewModel {
  RoutesViewModel() {
    orderService.getRoutes();
  }

  final orderService = injector<OrderService>();

  void goToDetail(List<Order> orderList, int index) =>
      ExtendedNavigator.root.push(
        Routes.routeDetailPage,
        arguments: RouteDetailPageArguments(
          orderList: orderList,
          routeIndex: index,
        ),
      );

  void goToOrders() => ExtendedNavigator.root.push(Routes.listOrdersPage);
}
