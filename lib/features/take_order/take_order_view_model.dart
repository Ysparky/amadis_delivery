import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/core/config/view_model.dart';
import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/core/utils/data.dart';
import 'package:amadis_delivery/services/customer_service.dart';
import 'package:amadis_delivery/services/location_service.dart';
import 'package:amadis_delivery/services/order_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TakeOrderViewModel extends AmadisViewModel {
  TakeOrderViewModel();

  final _shippingDateController = TextEditingController(text: 'dd/mm/yyyy');
  final _addressController = TextEditingController(text: 'Indica tu dirección');
  final _editQtyController = TextEditingController(text: '0');

  TextEditingController get shippingDateController => _shippingDateController;
  TextEditingController get selectedCustomerController => _onSelectedCustomer();
  TextEditingController get addressController => _addressController;
  TextEditingController get editQtyController => _editQtyController;

  final customerService = injector<CustomerService>();
  final locationService = injector<LocationService>();
  final orderService = injector<OrderService>();

  List<Product> get productsList => products;

  var orderTypeId = 1;

  var activeProduct = products.first;
  List<OrderDetail> orderDetail = [];

  int _getIndexByActiveProduct() {
    return orderDetail.indexWhere((d) => d.product.id == activeProduct.id);
  }

  void editDetailQuantity(int qty) {
    final index = _getIndexByActiveProduct();
    // product exists
    if (index != -1) {
      if (qty == 0) {
        orderDetail.removeAt(index);
      } else {
        orderDetail[index] = orderDetail[index].copyWith(
          quantity: qty,
          totalPrice: qty * activeProduct.price,
        );
      }
    } else if (qty != 0) {
      final detail = OrderDetail(
        product: activeProduct,
        quantity: qty,
        totalPrice: qty * activeProduct.price,
      );
      orderDetail.add(detail);
    }
    notifyListeners();
  }

  void addDetailQuantity() {
    final index = _getIndexByActiveProduct();
    if (index != -1) {
      final qty = orderDetail[index].quantity;
      orderDetail[index] = orderDetail[index].copyWith(
        quantity: qty + 1,
        totalPrice: (qty + 1) * activeProduct.price,
      );
      _editQtyController.text = orderDetail[index].quantity.toString();
    } else {
      final detail = OrderDetail(
        product: activeProduct,
        quantity: 1,
        totalPrice: activeProduct.price,
      );
      _editQtyController.text = '1';
      orderDetail.add(detail);
    }
    notifyListeners();
  }

  void removeDetailQuantity() {
    final index = _getIndexByActiveProduct();
    if (index != -1) {
      final qty = orderDetail[index].quantity;
      if (qty > 1) {
        orderDetail[index] = orderDetail[index].copyWith(
          quantity: qty - 1,
          totalPrice: (qty - 1) * activeProduct.price,
        );
        _editQtyController.text = orderDetail[index].quantity.toString();
      } else if (qty <= 1) {
        orderDetail.removeAt(index);
        _editQtyController.text = '0';
      }
      notifyListeners();
    }
  }

  void calculateSubtotal(int index) {
    final detail = orderDetail[index];
    orderDetail[index] =
        detail.copyWith(totalPrice: detail.quantity * detail.product.price);
  }

  void onChangedProduct(Product product) {
    activeProduct = product;
    final index = _getIndexByActiveProduct();
    if (index != -1) {
      _editQtyController.text = orderDetail[index].quantity.toString();
    } else {
      _editQtyController.text = '0';
    }
    notifyListeners();
  }

  void selectDate(BuildContext context, FocusNode node) async {
    // date validation
    final firstDate = DateTime.now().add(Duration(days: 7));
    final lastDate = DateTime.now().add(Duration(days: 30));
    // show datePicker
    final datePicked = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: Locale('es'),
    );
    if (datePicked != null) {
      final dateEsFormat = DateFormat.yMMMMEEEEd('es').format(datePicked);
      _shippingDateController.text = dateEsFormat;
      node.nextFocus();
    }
  }

  List<DropdownMenuItem<int>> get orderTypeDrowpdown => orderTypes
      .map(
        (e) => DropdownMenuItem(
          child: Text(e.name),
          value: e.id,
        ),
      )
      .toList();

  List<DropdownMenuItem<Product>> get productsDropdown => products
      .map((p) => DropdownMenuItem(
            child: Text(p.name),
            value: p,
          ))
      .toList();

  void orderTypeChanged(dynamic value, FocusNode node) {
    orderTypeId = value;
    node.nextFocus();
  }

  void goToSelectCustomer(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    ExtendedNavigator.root.push(Routes.selectCustomerPage);
  }

  TextEditingController _onSelectedCustomer() {
    final customer = customerService.selectedCustomer.value;
    if (customer != null) {
      return TextEditingController(
        text: '${customer.name} ${customer.lastName}',
      );
    } else {
      return TextEditingController(text: 'Seleccione un cliente');
    }
  }

  void createOrder() async {
    setLoading(true);
    final order = Order(
      customerId: customerService.selectedCustomer.value.customerId,
      location: locationService.selectedLocation.value,
      ordersDetail: orderDetail,
      orderTypeId: orderTypeId,
      orderStateId: 1,
    );
    final response = await orderService.createOrder(order);
    setLoading(false);
    if (response != null) {
      if (response) {
        showMessageSnackBar('¡Hemos recibido el pedido!');
      } else {
        showErrorSnackBar('Ocurrió un error');
      }
    } else {
      showErrorSnackBar('Ocurrió un error');
    }
  }

  @override
  void dispose() {
    customerService.selectedCustomer.add(null);
    super.dispose();
  }
}
