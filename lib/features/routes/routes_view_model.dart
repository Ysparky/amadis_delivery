import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:auto_route/auto_route.dart';

class RoutesViewModel extends AmadisViewModel {
  RoutesViewModel();

  void goToDetail() => ExtendedNavigator.root.push(Routes.routeDetailPage);
}
