import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:flutter/widgets.dart';

class CashOrderViewModel extends AmadisViewModel {
  CashOrderViewModel({this.originalOrder}) {
    order = originalOrder.copyWith();
    _calculateOrderSubtotalPrice();
  }

  final ScrollController scrollController = ScrollController();

  final Order originalOrder;
  Order order;

  double _subtotalPrice = 0.00;
  double get subtotalPrice => _subtotalPrice;

  void _calculateOrderSubtotalPrice() {
    order.ordersDetail.forEach((detail) {
      _subtotalPrice += detail.totalPrice;
    });
  }

  void editMissingBottlesQuantity(int qty) {
    var totalBoxQty = _getTotalBoxQty();
    var maxBottlesQty = 12 * totalBoxQty;
    if (qty <= maxBottlesQty && qty >= 0) {
      order = order.copyWith(missingBottlesQuantity: qty);
      _updateBottlesCharges();
      notifyListeners();
    }
  }

  void editMissingBoxQuantity(int qty) {
    var totalBoxQty = _getTotalBoxQty();
    if (qty <= totalBoxQty && qty >= 0) {
      order = order.copyWith(missingBoxQuantity: qty);
      _updateBoxCharges();
      notifyListeners();
    }
  }

  int _getTotalBoxQty() {
    var totalQty = 0;
    order.ordersDetail.forEach((detail) {
      totalQty += detail.quantity;
    });
    return totalQty;
  }

  double _boxCharges = 0.00;
  double get boxCharges => _boxCharges;

  double _bottlesCharges = 0.00;
  double get bottlesCharges => _bottlesCharges;

  void _updateBoxCharges() {
    _boxCharges = order.missingBoxQuantity * 4.00;
  }

  void _updateBottlesCharges() {
    _bottlesCharges = order.missingBottlesQuantity * 1.00;
  }
}
