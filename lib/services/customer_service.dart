import 'package:dio/dio.dart';

import 'package:amadis_delivery/core/utils/constants.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:rxdart/rxdart.dart';

class CustomerService {
  CustomerService() {
    selectedCustomer = BehaviorSubject<Customer>.seeded(null);
    customers = BehaviorSubject<List<Customer>>.seeded(null);
    filteredList = BehaviorSubject<List<Customer>>.seeded(null);
  }

  final _dio = Dio();
  final _endpoint = '$BASE_URL/customers/';

  BehaviorSubject<Customer> selectedCustomer;
  BehaviorSubject<List<Customer>> customers;
  BehaviorSubject<List<Customer>> filteredList;

  Future<void> getCustomers() async {
    try {
      final response = await _dio.get(_endpoint);
      final _customers = List<Customer>.from(
          response.data['data'].map((x) => Customer.fromJson(x)));
      customers.add([..._customers]);
      filteredList.add([..._customers]);
    } catch (e) {
      print('Not this time');
    }
  }
}
