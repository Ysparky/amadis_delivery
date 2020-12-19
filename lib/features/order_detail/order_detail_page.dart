import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/core/widgets/widgets.dart';
import 'package:amadis_delivery/features/order_detail/widgets/widgets.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/features/order_detail/order_detail_view_model.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({
    Key key,
    this.order,
  }) : super(key: key);

  final Order order;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => OrderDetailViewModel(order: order)),
      ],
      child: LoadingOverlay<OrderDetailViewModel>(
        child: OrderDetailPageBase(),
      ),
    );
  }
}

class OrderDetailPageBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<OrderDetailViewModel>(context);
    return Scaffold(
      key: _viewModel.scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xffF6F6F6),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomFloatingButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () => Navigator.pop(context),
            ),
            CustomFloatingButton(
              icon: Icon(Icons.near_me_rounded),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            height: hp(30),
            width: wp(100),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  _viewModel.fullOrder?.location?.coordinates?.latitude,
                  _viewModel.fullOrder?.location?.coordinates?.longitude,
                ),
                zoom: 15,
              ),
              onMapCreated: _viewModel.onMapCreated,
              markers: _viewModel.setCustomerMarker(),
              rotateGesturesEnabled: false,
              scrollGesturesEnabled: false,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            height: hp(75),
            width: wp(100),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  color: AmadisColors.backgroundColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(2)),
                  child: Column(
                    children: [
                      OrderDataCard(),
                      SizedBox(height: hp(2)),
                      CustomerDataCard(),
                      SizedBox(height: hp(2)),
                      OrderDetailCard(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
