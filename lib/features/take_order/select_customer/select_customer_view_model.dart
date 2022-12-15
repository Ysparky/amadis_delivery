import 'package:auto_route/auto_route.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/services/customer_service.dart';

class SelectCustomerViewModel extends AmadisViewModel {
  SelectCustomerViewModel() {
    customerService.getCustomers();
  }

  final customerService = injector<CustomerService>();

  Stream<List<Customer>> get customers => customerService.customers;

  Stream<List<Customer>> get filteredList => customerService.filteredList;

  void handleCustomerSearch(String query) async {
    if (query.trim().isEmpty) {
      customerService.filteredList
          .add(customerService.customers.value.toList());
    } else {
      customerService.filteredList.add(_getFilteredList(query));
    }
  }

  List<Customer> _getFilteredList(String query) {
    return customerService.customers.value
        .where((c) =>
            c.name.toLowerCase().startsWith(query.trim()) ||
            c.lastName.toLowerCase().startsWith(query.trim()) ||
            '${c.name.toLowerCase()} ${c.lastName.toLowerCase()}'
                .startsWith(query.toLowerCase()))
        .toList();
  }

  void selectCustomer(Customer customer) {
    customerService.selectedCustomer.add(customer);
    ExtendedNavigator.root.pop();
  }
}
