import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:flutter/widgets.dart';

class ConsignmentOrderViewModel extends AmadisViewModel {
  ConsignmentOrderViewModel({this.orignalOrder}) {
    order = orignalOrder.copyWith();
    order.ordersDetail.toList().asMap().forEach((idx, detail) {
      consumedList.add(detail.copyWith(quantity: 0, totalPrice: 0.00));
    });
  }

  final ScrollController scrollController = ScrollController();

  final Order orignalOrder;
  Order order;
  List<OrderDetail> consumedList = [];

  void editConsumedBoxes(int qty, int index) {
    var maxBoxesQty = 0.0;
    consumedList.toList().asMap().forEach((idx, detail) {
      maxBoxesQty += idx != index ? detail.quantity : qty;
    });
    var maxBottlesQty = 12 * maxBoxesQty;
    if (maxBottlesQty < order.missingBottlesQuantity) {
      showErrorSnackBar('Asegúrate de disminuir las botellas faltantes.');
    } else if (maxBoxesQty < order.missingBoxQuantity) {
      showErrorSnackBar('Asegúrate de disminuir las cajas faltantes.');
    } else {
      if (qty >= 0 && qty <= order.ordersDetail[index].quantity) {
        consumedList[index] = consumedList[index].copyWith(quantity: qty);
        _calculateProductSubtotalPrice(index);
        notifyListeners();
      }
    }
  }

  void _calculateProductSubtotalPrice(int index) {
    var unitPrice = order.ordersDetail[index].product.price;
    consumedList[index] = consumedList[index].copyWith(
      totalPrice: unitPrice * consumedList[index].quantity,
    );
    _calculateOrderSubtotalPrice();
  }

  double _subtotalPrice = 0.00;
  double get subtotalPrice => _subtotalPrice;

  void _calculateOrderSubtotalPrice() {
    consumedList.forEach((detail) {
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
    consumedList.forEach((detail) {
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
