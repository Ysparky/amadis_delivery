import 'package:amadis_delivery/core/config/view_model.dart';
import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/models/order.dart';
import 'package:amadis_delivery/services/order_service.dart';

class ListOrdersViewModel extends AmadisViewModel {
  ListOrdersViewModel() {
    _statesList = [
      orderStates[0],
      orderStates[1],
      orderStates[4],
      orderStates[7],
    ];
    // _statesList = orderStates.toList();
    _activeState = _statesList.first;
    // final index = _statesList.indexWhere((state) => state.id == initialStateId);
    _statesList[0] = _statesList[0].copyWith(selected: true);
    orderService.getOrders(stateId: _activeState.id);
  }

  final orderService = injector<OrderService>();

  Stream<List<Order>> get orders => orderService.orders;

  List<OrderState> _statesList = [];
  List<OrderState> get ordersState => _statesList;

  OrderState _activeState;
  OrderState get activeState => _activeState;

  Future<void> getOrders(int stateId) async {
    setLoading(true);
    await orderService.getOrders(stateId: stateId);
    setLoading(false);
    notifyListeners();
  }

  void handleTap(OrderState orderState) {
    final index = _statesList.indexWhere((state) => state.selected);
    final idx = _statesList.indexOf(orderState);
    if (index != idx) {
      _statesList[index] = _statesList[index].copyWith(selected: false);
      _statesList[idx] = _statesList[idx].copyWith(selected: true);
      _activeState = _statesList[idx];
      getOrders(orderState.id);
      notifyListeners();
    }
  }
}
