import 'package:dio/dio.dart';

import 'package:amadis_delivery/core/utils/constants.dart';
import 'package:amadis_delivery/models/order.dart';

class OrderService {
  OrderService();

  final _dio = Dio();
  final _endpoint = '$BASE_URL/orders/';

  Future<List<Order>> getOrders() async {
    try {
      final response = await _dio.get(_endpoint, options: dioOptions);
      return List<Order>.from(
        response.data['data'].map((x) => Order.fromJson(x)),
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Order> getOrderById(int id) async {
    try {
      final responde = await _dio.get('$_endpoint$id', options: dioOptions);
      return Order.fromJson(responde.data['data']);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> createOrder(Order order) async {
    try {
      final response =
          await _dio.post(_endpoint, data: order.toJson(), options: dioOptions);
      final success = (response.statusCode == 200) ? true : false;
      return success;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> additionalCharges(Order order) async {
    try {
      final endpoint = '$BASE_URL/notification/';
      final data = {
        'orderId': order.id,
        'missingBottlesQuantity': order.missingBottlesQuantity,
        'missingBoxQuantity': order.missingBoxQuantity,
        'missingBottlesPrice': '1.00',
        'missingBoxesPrice': '4.00',
      };
      final response =
          await _dio.post(endpoint, data: data, options: dioOptions);
      final success = (response.statusCode == 200) ? true : false;
      return success;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
