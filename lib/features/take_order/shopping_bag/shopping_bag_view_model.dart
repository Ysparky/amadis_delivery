import 'package:auto_route/auto_route.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/services/order_service.dart';
import 'package:amadis_delivery/services/product_service.dart';

class ShoppingBagViewModel extends AmadisViewModel {
  ShoppingBagViewModel() {
    _productService.getProducts();
    if (orderService.orderDetail.value != null) {
      orderDetail = orderService.orderDetail.value.toList();
    }
  }

  final _productService = injector<ProductService>();
  final orderService = injector<OrderService>();

  Stream<List<ProductPresentation>> get productPresentationList =>
      _productService.productPresentationList;

  List<OrderDetail> orderDetail = [];

  void addProducts() {
    if (orderDetail.isNotEmpty) {
      orderService.orderDetail.add(orderDetail.toList());
    }
    ExtendedNavigator.root.pop();
  }

  void handleEditDetailQuantity(
      ProductPresentation productPresentation, String value) {
    if (value.isNotEmpty) {
      final qty = int.tryParse(value);
      if (qty > 0) {
        final index = orderDetail.indexWhere((detail) =>
            detail.productPresentation.id == productPresentation.id);
        if (index != -1) {
          final currentDetail = orderDetail[index];
          orderDetail[index] = currentDetail.copyWith(
            quantity: qty,
            totalPrice: productPresentation.price * qty,
          );
        } else {
          final newDetail = OrderDetail(
            quantity: qty,
            productPresentation: productPresentation,
            totalPrice: productPresentation.price * qty,
          );
          orderDetail.add(newDetail);
        }
      }
    } else {
      //removes the object
      final index = orderDetail.indexWhere(
          (detail) => detail.productPresentation.id == productPresentation.id);
      if (index != -1) {
        orderDetail.removeAt(index);
      }
    }
    notifyListeners();
  }

  void handleAddDetailQuantity(ProductPresentation productPresentation) {
    //if exists
    final index = orderDetail.indexWhere(
        (detail) => detail.productPresentation.id == productPresentation.id);
    if (index != -1) {
      print('added quantity to a product');
      final currentDetail = orderDetail[index];
      final newQty = currentDetail.quantity + 1;
      orderDetail[index] = currentDetail.copyWith(
        quantity: newQty,
        totalPrice: productPresentation.price * newQty,
      );
    } else {
      print('added new product');
      final newDetail = OrderDetail(
          quantity: 1,
          productPresentation: productPresentation,
          totalPrice: productPresentation.price);
      orderDetail.add(newDetail);
    }
    notifyListeners();
  }

  void handleRemoveDetailQuantity(ProductPresentation productPresentation) {
    final index = orderDetail.indexWhere(
        (detail) => detail.productPresentation.id == productPresentation.id);
    if (index != -1) {
      final currentDetail = orderDetail[index];
      if (currentDetail.quantity > 1) {
        final newQty = currentDetail.quantity - 1;
        orderDetail[index] = currentDetail.copyWith(
          quantity: newQty,
          totalPrice: productPresentation.price * newQty,
        );
      } else {
        orderDetail.removeAt(index);
      }
    }
    notifyListeners();
  }

  int getQuantity(ProductPresentation productPresentation) {
    final index = orderDetail.indexWhere(
        (detail) => detail.productPresentation.id == productPresentation.id);
    return index != -1 ? orderDetail[index].quantity : 0;
  }
}
