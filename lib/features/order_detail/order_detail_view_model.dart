import 'dart:collection';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/services/order_service.dart';
import 'package:map_launcher/map_launcher.dart';

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

  void goToMap(BuildContext context) {
    if (_fullOrder != null) {
      _handleLaunchMap(context);
    } else {
      showErrorSnackBar(
        'Recibiendo información de la orden, inténtenlo más tarde.',
      );
    }
  }

  void goToAdditionalCharges() {
    switch (_fullOrder.orderTypeId) {
      case 1:
        ExtendedNavigator.root.push(Routes.cashOrderPage,
            arguments: CashOrderPageArguments(order: _fullOrder));
        break;
      case 2:
        ExtendedNavigator.root.push(Routes.consignmentOrderPage,
            arguments: ConsignmentOrderPageArguments(order: _fullOrder));
        break;
      default:
        showErrorSnackBar('Ocurrió un error');
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

  double getTotalAmount() {
    var totalAmount = 0.0;
    _fullOrder.ordersDetail.forEach((detail) {
      final productPrice = detail.quantity * detail.product.price;
      totalAmount += productPrice;
    });
    return totalAmount;
  }

  void _handleLaunchMap(BuildContext context) async {
    final availableMaps = await MapLauncher.installedMaps;
    final _coords = _fullOrder.location.coordinates;
    final destination = Coords(_coords.latitude, _coords.longitude);

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
            child: SingleChildScrollView(
          child: Container(
            child: Wrap(
              children: [
                ...availableMaps.map((map) => ListTile(
                      title: Text(map.mapName),
                      leading: SvgPicture.asset(
                        map.icon,
                        height: 30.0,
                        width: 30.0,
                      ),
                      onTap: () => map.showDirections(
                        destinationTitle: _fullOrder.location.address,
                        destination: destination,
                      ),
                    ))
              ],
            ),
          ),
        ));
      },
    );
  }
}
