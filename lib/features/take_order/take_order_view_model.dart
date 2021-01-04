import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/services/customer_service.dart';
import 'package:amadis_delivery/services/location_service.dart';
import 'package:amadis_delivery/services/order_service.dart';
import 'package:amadis_delivery/services/product_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TakeOrderViewModel extends AmadisViewModel {
  TakeOrderViewModel();

  final _shippingDateController = TextEditingController(text: 'dd/mm/yyyy');
  final _addressController = TextEditingController(text: 'Indica tu dirección');
  final _editQtyController = TextEditingController(text: '0');

  TextEditingController get shippingDateController => _shippingDateController;
  TextEditingController get addressController => _addressController;
  TextEditingController get editQtyController => _editQtyController;

  final customerService = injector<CustomerService>();
  final locationService = injector<LocationService>();
  final orderService = injector<OrderService>();
  final productService = injector<ProductService>();

  List<ProductPresentation> get productsPresentationList =>
      productsPresentation;

  var orderTypeId = 1;

  var activeProductPresentation = productsPresentation.first;
  Stream<List<OrderDetail>> get orderDetail => orderService.orderDetail;

  Stream<Customer> get selectedCustomer => customerService.selectedCustomer;

  Stream<List<ProductPresentation>> get productPresentationList =>
      productService.productPresentationList;

  DateTime datePicked;

  List<DropdownMenuItem<int>> get orderTypeDrowpdown => orderTypes
      .map(
        (e) => DropdownMenuItem(
          child: Text(e.name),
          value: e.id,
        ),
      )
      .toList();

  List<DropdownMenuItem<ProductPresentation>> get productsDropdown =>
      productsPresentation
          .map((p) => DropdownMenuItem(
                child: Text(p.product.name + ' ' + p.presentation.name),
                value: p,
              ))
          .toList();

  void goToShoppingBag() {
    ExtendedNavigator.root.push(Routes.shoppingBagPage);
  }

  void selectDate(BuildContext context, FocusNode node) async {
    // date validation
    final firstDate = DateTime.now().add(Duration(days: 7));
    final lastDate = DateTime.now().add(Duration(days: 30));
    // show datePicker
    datePicked = await showDatePicker(
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

  void orderTypeChanged(dynamic value, FocusNode node) {
    orderTypeId = value;
    node.nextFocus();
  }

  void goToSelectCustomer(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    ExtendedNavigator.root.push(Routes.selectCustomerPage);
  }

  bool _validateOrder() {
    if (_shippingDateController.value.text == 'dd/mm/yyyy') {
      showErrorSnackBar('Selecciona la fecha de envío');
      return false;
    } else if (customerService.selectedCustomer.value == null) {
      showErrorSnackBar('No ha seleccionado un cliente');
      return false;
    } else if (locationService.selectedLocation.value == null) {
      showErrorSnackBar('Defina la dirección a realizar el envío');
      return false;
    } else if (orderService.orderDetail.value?.isEmpty ?? true) {
      showErrorSnackBar('¡No hay productos agregados al pedido!');
      return false;
    } else {
      return true;
    }
  }

  void _createOrder() async {
    setLoading(true);
    final order = Order(
      shippingDate: DateFormat.yMd('en_US').format(datePicked),
      customerId: customerService.selectedCustomer.value.customerId,
      location: locationService.selectedLocation.value,
      ordersDetail: orderService.orderDetail.value,
      orderTypeId: orderTypeId,
      orderStateId: 1,
    );
    final response = await orderService.createOrder(order);
    setLoading(false);
    if (response != null) {
      if (response) {
        showMessageSnackBar('¡Hemos recibido el pedido!',
            duration: Duration(seconds: 1));
        await Future.delayed(Duration(milliseconds: 1100));
        await ExtendedNavigator.root.popAndPush(Routes.dashboardPage,
            arguments: DashboardPageArguments(initialPage: 2));
      } else {
        showErrorSnackBar('Ocurrió un error');
      }
    } else {
      showErrorSnackBar('Ocurrió un error');
    }
  }

  void createOrder() async {
    if (_validateOrder()) {
      await _createOrder();
    }
  }

  @override
  void dispose() {
    customerService.selectedCustomer.add(null);
    orderService.orderDetail.add(null);
    super.dispose();
  }
}
