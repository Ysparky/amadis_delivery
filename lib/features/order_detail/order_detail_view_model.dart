import 'dart:collection';
import 'dart:convert';

import 'package:amadis_delivery/core/widgets/widgets.dart';
import 'package:amadis_delivery/networking/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';

import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:amadis_delivery/services/order_service.dart';

class OrderDetailViewModel extends AmadisViewModel {
  OrderDetailViewModel({this.order}) {
    if (order.ordersDetail != null) {
      _fullOrder = order;
      _showActions = true;
      print(order.isDelivery);
    } else {
      getOrderDetailById();
    }
  }

  final _orderService = injector<OrderService>();

  final Order order;

  Order _fullOrder;
  Order get fullOrder => _fullOrder;

  bool _showActions = false;
  bool get showActions => _showActions;

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

  void updateConsignmentOrder() async {
    //TODO: Uncomment this block
    print(_fullOrder.id);
    var orderId = _fullOrder.id;
    // setLoading(true);
    // var success = await _orderService.deliverConsignmentOrder(orderId);
    // setLoading(false);
    // if (success) {
    await _showSuccessUpdate();
    // } else {
    //   showErrorSnackBar(
    //     'No se pudo actualizar el estado, inténtelo más tarde.',
    //   );
    // }
  }

  void _handleRoutes() async {
    var selectedRoute = _orderService.selectedRoute.value;
    //go to next step if not the last one
    final ordersQty = selectedRoute.orders.length;

    //get the active order idx from the route
    final activeOrderIdx =
        selectedRoute.orders.indexWhere((order) => order.isOrderActive);

    selectedRoute.orders[activeOrderIdx] =
        selectedRoute.orders[activeOrderIdx].copyWith(
      isOrderActive: false,
      isOrderDelivered: true,
    );
    final nextIdx = activeOrderIdx + 1;
    if (ordersQty != nextIdx) {
      selectedRoute.orders[nextIdx] =
          selectedRoute.orders[nextIdx].copyWith(isOrderActive: true);
      ExtendedNavigator.root.popUntilRoot();
      await ExtendedNavigator.root.push(
        Routes.routeDetailPage,
        arguments: RouteDetailPageArguments(selectedRoute: selectedRoute),
      );
    } else {
      selectedRoute = selectedRoute.copyWith(
        isRouteActive: false,
        isRouteFinished: true,
      );

      var myRoutes = _orderService.routes.value.data;
      var index = _orderService.selectedRouteIndex.value;
      myRoutes[index] = selectedRoute;

      _orderService.routes.add(ApiResponse.completed(myRoutes));
      _orderService.selectedRoute.add(null);
      _orderService.selectedRouteIndex.add(null);
      await _showSuccessDelivery();
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
      final productPrice = detail.quantity * detail.productPresentation.price;
      totalAmount += productPrice;
    });
    return totalAmount;
  }

  void _handleLaunchMap(BuildContext context) async {
    final availableMaps = await MapLauncher.installedMaps;
    final _coords = _fullOrder.location.coordinates;
    final destination = Coords(_coords.latitude, _coords.longitude);

    if (availableMaps.length > 1) {
      await _showModalBottomSheet(context, availableMaps, destination);
    } else if (availableMaps.length == 1) {
      await availableMaps.first.showDirections(destination: destination);
    } else {
      showErrorSnackBar('No hay aplicaciones soportadas instaladas');
    }
  }

  void _showModalBottomSheet(
      BuildContext context, List availableMaps, Coords destination) async {
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

  void _showSuccessUpdate() async {
    await showDialog(
      context: scaffoldKey.currentContext,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: CustomModal(
          showCloseButton: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(AmadisAssets.svg_check_mark, height: hp(10)),
              SizedBox(height: hp(2.0)),
              Text(
                'El pedido ha sido entregado con éxito!',
                style: Theme.of(scaffoldKey.currentContext)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: hp(2.0)),
              SizedBox(
                width: wp(35),
                child: CustomButton(
                  onPressed: _handleRoutes,
                  text: 'ACEPTAR',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDelivery() async {
    await showDialog(
      context: scaffoldKey.currentContext,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: CustomModal(
          showCloseButton: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AmadisAssets.success_delivery, height: hp(10)),
              SizedBox(height: hp(2.0)),
              Text(
                '¡Se han completado todos los pedidos de la ruta!',
                textAlign: TextAlign.center,
                style: Theme.of(scaffoldKey.currentContext)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: hp(2.0)),
              SizedBox(
                width: wp(35),
                child: CustomButton(
                  onPressed: () {
                    ExtendedNavigator.root.popUntilRoot();
                  },
                  text: 'ACEPTAR',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
