import 'dart:convert';

import 'package:amadis_delivery/networking/api_base_helper.dart';
import 'package:amadis_delivery/networking/api_response.dart';
import 'package:dio/dio.dart';

import 'package:amadis_delivery/core/utils/constants.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:rxdart/rxdart.dart';

class OrderService {
  OrderService() {
    orders = BehaviorSubject<List<Order>>.seeded(null);
    selectedOrder = BehaviorSubject<List<Order>>.seeded(null);
    orderDetail = BehaviorSubject<List<OrderDetail>>.seeded(null);
    routes = BehaviorSubject<ApiResponse<List<List<Order>>>>.seeded(null);
  }

  BehaviorSubject<List<Order>> orders;
  BehaviorSubject<List<OrderDetail>> orderDetail;
  BehaviorSubject<List<Order>> selectedOrder;

  final _dio = Dio();
  final _endpoint = '$BASE_URL/orders/';

  Future<void> getOrders({int stateId = 1}) async {
    try {
      final params = {'orderStateId': stateId};
      final response = await _dio.get(
        _endpoint,
        options: dioOptions,
        queryParameters: params,
      );
      final _orders = List<Order>.from(
        response.data['data'].map((x) => Order.fromJson(x)),
      );
      orders.add([..._orders]);
    } catch (e) {
      print(e);
    }
  }

  Future<Order> getOrderById(int id) async {
    try {
      final responde = await _dio.get('$_endpoint$id', options: dioOptions);
      final order = Order.fromJson(responde.data['data']);
      return order;
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

  Future<bool> additionalCharges(
    Order order,
    List<OrderDetail> consumedList,
  ) async {
    try {
      final endpoint = '$BASE_URL/notification/';
      final data = {
        'orderId': order.id,
        'missingBottlesQuantity': order.missingBottlesQuantity,
        'missingBoxQuantity': order.missingBoxQuantity,
        'missingBottlesPrice': '1.00',
        'missingBoxesPrice': '4.00',
        'ordersRemaining': consumedList == null
            ? null
            : List<dynamic>.from(consumedList.map((e) => e.toReamingJson())),
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

  BehaviorSubject<ApiResponse<List<List<Order>>>> routes;

  final _helper = ApiBaseHelper();
  Future<void> getRoutes() async {
    routes.add(ApiResponse.loading('Fetching order detail'));
    final response =
        await _helper.get('/orders/routes/list?shippingDate=2021-01-09');
    if (response != null) {
      final str = json.encode(response.data);
      final _routes = routesFromJson(str);
      routes.add(ApiResponse.completed(_routes));
    } else {
      routes.add(ApiResponse.error(response.message, response.statusCode));
    }
  }
}
