import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/core/config/view_model.dart';
import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/services/customer_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TakeOrderViewModel extends AmadisViewModel {
  TakeOrderViewModel();

  final _shippingDateController = TextEditingController(text: 'dd/mm/yyyy');
  final _addressController = TextEditingController(text: 'Indica tu dirección');

  TextEditingController get shippingDateController => _shippingDateController;
  TextEditingController get selectedCustomerController => _onSelectedCustomer();
  TextEditingController get addressController => _addressController;

  var orderTypeId = 1;
  final customerService = injector<CustomerService>();

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

  @override
  void dispose() {
    print('ddddddd');
    print(customerService.selectedCustomer?.value?.name);
    customerService.selectedCustomer.add(null);
    super.dispose();
  }
}
