import 'dart:collection';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/services/order_service.dart';

class OrderDetailViewModel extends AmadisViewModel {
  OrderDetailViewModel({this.order}) {
    getOrderDetailById();
  }

  final _orderService = injector<OrderService>();

  final Order order;

  Order _fullOrder;
  Order get fullOrder => _fullOrder;

  void goBack() {
    ExtendedNavigator.root.pop();
  }

  void goToMap() {
    if (_fullOrder != null) {
      print('go to next page');
    } else {
      print('do nothing');
    }
  }

  Future<void> getOrderDetailById() async {
    _fullOrder = await _orderService.getOrderById(order.id);
  }

  void makePhoneCall() async {
    final phone = '+51 ${_fullOrder.contactNumber}';
    await FlutterPhoneDirectCaller.callNumber(phone);
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(jsonEncode(blueGrayMapTheme));
  }

  Set<Marker> setCustomerMarker() {
    Set<Marker> _customerMarker = HashSet<Marker>();
    final customerMarker = Marker(
      markerId: MarkerId('customerMarker'),
      position: _fullOrder.location.coordinates,
    );
    _customerMarker.add(customerMarker);
    return _customerMarker;
  }
}
